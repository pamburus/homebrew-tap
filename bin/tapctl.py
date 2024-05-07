#!/usr/bin/env python3

'''Manage the homebrew tap.'''

import argparse
import functools
import glob
import hashlib
import json
import logging
import os
import re
import shlex
import subprocess
import sys
import typing
import urllib.parse
import urllib.request

from functools import cached_property


# Directory of the current script.
THIS_DIR = os.path.dirname(__file__)

# Upstream repository of the homebrew tap.
UPSTREAM_REPO = 'https://github.com/pamburus/homebrew-bin'

# Main branch of the repository.
MAIN_BRANCH = 'main'

# Command to render the template.
RENDER_COMMAND = ['go', 'run', 'github.com/bitnami/render-template@v1.0.6']

# Directories for the formula and the target.
FORMULA_SOURCE_DIR = 'src/formula'
FORMULA_TARGET_DIR = 'Formula'


class AnsiStyle:
    '''ANSI style for the text.'''
    def __init__(self, *codes: int):
        self._codes = codes

    def format(self, text: str) -> str:
        '''Format the text with the style.'''
        if os.environ.get('NO_COLOR') == '1' or os.environ.get('TERM') == 'dumb':
            return text
        return f'\033[{";".join(map(str, self._codes))}m{text}\033[0m'

    def plus(self, other: 'AnsiStyle') -> 'AnsiStyle':
        '''Combine the styles.'''
        return self + other

    def __add__(self, other: 'AnsiStyle') -> 'AnsiStyle':
        return AnsiStyle(*self._codes, *other._codes)

    def __iadd__(self, other: 'AnsiStyle') -> 'AnsiStyle':
        self._codes += other._codes
        return self

    def __call__(self, text: str) -> str:
        return self.format(text)


class AnsiColor:
    '''ANSI color for the text.'''
    def __init__(self, code: int, bright: bool = False):
        if code < 0 or code > 7:
            raise ValueError(f'Invalid color code: {code}')
        self._code = code
        self._bright = bright

    @property
    def bright(self):
        '''Return the bright version of the color.'''
        return AnsiColor(self._code, True)

    @property
    def normal(self):
        '''Return the normal version of the color.'''
        return AnsiColor(self._code, False)

    @property
    def fg(self) -> AnsiStyle:
        '''Return the foreground style of the color.'''
        return AnsiStyle(30 + self._code + (60 if self._bright else 0))

    @property
    def bg(self) -> AnsiStyle:
        '''Return the background style of the color.'''
        return AnsiStyle(40 + self._code + (60 if self._bright else 0))

    def format(self, text: str) -> str:
        '''Format the text with the color as foreground color.'''
        return self.fg(text)

    def __call__(self, text):
        return self.format(text)


# ANSI attributes for the colors.
BOLD = AnsiStyle(1)
FAINT = AnsiStyle(2)
BLACK = AnsiColor(0)
RED = AnsiColor(1)
GREEN = AnsiColor(2)
YELLOW = AnsiColor(3)
BLUE = AnsiColor(4)
MAGENTA = AnsiColor(5)
CYAN = AnsiColor(6)
WHITE = AnsiColor(7)
HL = GREEN.fg


def log_command(command, *_args, **kwargs):
    '''Log the command to the standard error.'''
    message = prompt() + HL(shlex.join(command))
    context = dict(filter(lambda x: x[0] in ['cwd'], kwargs.items()))
    if context:
        ks = HL.plus(FAINT)
        message += ' ' + ' '.join([ks(f'{k}=')+repr(v) for k, v in context.items()])
    logging.debug(message)


def log_pipe(style: 'AnsiStyle', data: bytes, header: bool = True, body: bool = True, level = logging.DEBUG):
    '''Log the stdout or stderr output.'''
    if not data:
        return
    if header:
        logging.debug(style(f'| -- {len(data)} bytes'))
    if body:
        prefix = style('| ')
        for line in data.rstrip().splitlines():
            try:
                s = line.decode()
            except UnicodeDecodeError:
                s = style('<binary data>')
            logging.log(level, prefix + s)


def log_stdout(data: bytes, header: bool = True, body: bool = True, level = logging.DEBUG):
    '''Log the stdout output.'''
    log_pipe(FAINT, data, header=header, body=body, level=level)


def log_stderr(data: bytes, header: bool = True, body: bool = True, level = logging.DEBUG):
    '''Log the stderr output.'''
    log_pipe(RED.fg, data, header=header, body=body, level=level)


def run_silent(command, *args, **kwargs):
    '''Run the command with the given arguments and keyword arguments.'''
    kwargs['stdout'] = subprocess.PIPE
    kwargs['stderr'] = subprocess.PIPE
    return subprocess.run(command, *args, check=False, **kwargs)


def run(command, *args, **kwargs):
    '''Run the command with the given arguments and keyword arguments.'''
    log_command(command, *args, **kwargs)
    result = run_silent(command, *args, **kwargs)
    log_stdout(result.stdout, level=logging.INFO if result.returncode else logging.DEBUG)
    log_stderr(result.stderr, level=logging.INFO if result.returncode else logging.DEBUG)
    result.check_returncode()
    return result


def bin_output(command, *args, **kwargs):
    '''Run the command with the given arguments and keyword arguments and return the output.'''
    log_command(command, *args, **kwargs)
    result = run_silent(command, *args, **kwargs)
    if result.returncode:
        log_stderr(result.stderr, level=logging.INFO)
    else:
        log_stdout(result.stdout, body=False)
    result.check_returncode()
    return result.stdout


def output(command, *args, **kwargs):
    '''Run the command with the given arguments and keyword arguments and return the output.'''
    result = bin_output(command, *args, **kwargs)
    log_stdout(result, header=False)
    return result.decode()


def read(filename):
    '''Read the content of the file.'''
    with open(filename, 'rb') as f:
        return f.read().decode()


def write(filename, content):
    '''Write the content to the file.'''
    with open(filename, 'wb') as f:
        f.write(content.encode())


def render(template, **env):
    '''Render the template with the given environment.'''
    env={**dict(os.environ), **env}
    return output(RENDER_COMMAND, input=template.encode(), env=env)


def get(url):
    '''Get the content of the URL.'''
    logging.debug('GET %s', CYAN(url))
    return urllib.request.urlopen(url)


def prompt():
    '''Prompt the user for a confirmation.'''
    return FAINT('> ')


def stdout_prefix():
    '''Prefix for the stdout pipe log.'''
    return FAINT('| ')


def stderr_prefix():
    '''Prefix for the stderr pipe log.'''
    return RED('| ')


def sha256(stream) -> str:
    '''Compute the SHA-256 checksum of the stream.'''
    block_size = 65536
    hasher = hashlib.sha256()
    buf = stream.read(block_size)
    while len(buf) > 0:
        hasher.update(buf)
        buf = stream.read(block_size)
    return hasher.hexdigest()


def normalize_release_ref(ref):
    '''Normalize the release reference.'''
    if ref == 'latest':
        return ref
    if not ref.startswith('tags/'):
        if not ref.startswith('v'):
            ref = f'v{ref}'
        ref = f'tags/{ref}'
    return ref


def normalized_release_ref(fn):
    '''Normalize the release reference.'''
    def wrapper(self, ref):
        return fn(self, normalize_release_ref(ref))
    return wrapper


class LocalGitRepo:
    '''A local git repository.'''

    def __init__(self, path):
        self.path = path

    @property
    def is_clean(self) -> bool:
        '''Check if the git repository is clean.'''
        return not output(['git', 'status', '--porcelain'], cwd=self.path).strip()

    def is_clean_except(self, *excludes) -> bool:
        '''Check if the git repository is clean except the given excludes.'''
        items = output(['git', 'status', '--porcelain'], cwd=self.path).rstrip()
        for item in items.splitlines():
            filename = item[3:]
            if not filename in excludes:
                return False
        return True

    @property
    def current_branch(self):
        '''Get the current git branch.'''
        return output(['git', 'branch', '--show-current'], cwd=self.path).strip()

    @property
    def current_commit(self):
        '''Get the current git commit.'''
        return output(['git', 'rev-parse', 'HEAD'], cwd=self.path).strip()

    def push(self, branch):
        '''Push the current branch to the remote repository.'''
        run(['git', 'push', 'origin', branch], cwd=self.path)

    def checkout(self, ref):
        '''Checkout the given ref.'''
        run(['git', 'checkout', ref], cwd=self.path)

    def create_branch(self, branch):
        '''Create a new branch with the given name.'''
        run(['git', 'checkout', '-b', branch], cwd=self.path)

    def add(self, *filenames):
        '''Add the file to the git repository.'''
        run(['git', 'add', *filenames], cwd=self.path)

    def commit(self, message):
        '''Commit the changes to the git repository.'''
        run(['git', 'commit', '-m', message], cwd=self.path)


class GitHubRelease:
    '''A GitHub release.'''

    def __init__(self, repo: 'GitHubRepo', ref: str = 'latest', meta=None):
        self._repo = repo
        self._ref = normalize_release_ref(ref)
        self._meta = meta

    def __str__(self):
        return f'{self.repo}@{self.ref}'

    def __eq__(self, other) -> bool:
        return self.repo == other and self.ref == other.ref

    def __hash__(self) -> int:
        return hash((self.repo, self.ref))

    @cached_property
    def resolved(self) -> 'GitHubRelease':
        '''The same release with a resolved and stable reference.'''
        if self.ref == 'latest':
            ref = f'tags/{self.meta["tag_name"]}'
            return GitHubRelease(self.repo, ref, meta=self.meta)
        return self

    @property
    def repo(self) -> 'GitHubRepo':
        '''The repository of the release.'''
        return self._repo

    @property
    def ref(self) -> str:
        '''The reference to the release.'''
        return self._ref

    @property
    def name(self) -> str:
        '''The name of the release.'''
        return self.meta['name']

    @property
    def assets(self) -> dict:
        '''The assets of the release.'''
        return {x['name']: x for x in self.meta['assets']}

    @property
    def version(self) -> str:
        '''The version corresponding to the release tag.'''
        return self.meta['tag_name'].lstrip('v')

    @cached_property
    def meta(self) -> dict:
        '''The metadata of the release.'''
        if self._meta:
            return self._meta
        with get(self.api_url) as stream:
            return json.load(stream)

    @property
    def api_url(self) -> str:
        '''The API URL of the release.'''
        return f'{self.repo.api_url}/releases/{self.ref}'


class GitHubRepo:
    '''A github repository.'''

    def __init__(self, owner: str, repo: str):
        self.owner = owner
        self.repo = repo

    @normalized_release_ref
    @functools.lru_cache(maxsize=16)
    def release(self, ref='latest') -> GitHubRelease:
        '''Get the release in the repository by the given reference.'''
        return GitHubRelease(self, ref)

    @property
    def api_url(self):
        '''The API URL of the repository.'''
        return f'https://api.github.com/repos/{self.owner}/{self.repo}'

    def __str__(self):
        return f'{self.owner}/{self.repo}'

    def __eq__(self, other) -> bool:
        return self.owner == other.owner and self.repo == other.repo

    def __hash__(self) -> int:
        return hash((self.owner, self.repo))


class FormulaAsset:
    '''An asset for a formula.'''

    def __init__(self, formula: 'Formula', spec: dict, release: GitHubRelease):
        self.formula = formula
        self.spec = spec
        self.release = release

    @property
    def name(self) -> str:
        '''The name of the asset.'''
        return self.spec['name']

    @property
    def os(self) -> str:
        '''The operating system of the asset.'''
        return self.spec['os']

    @property
    def arch(self) -> str:
        '''The architecture of the asset.'''
        return self.spec['arch']

    @property
    def url(self):
        '''The URL of the asset.'''
        return self.release.assets[self.name]['browser_download_url']

    @cached_property
    def sha256(self):
        '''Compute the SHA-256 checksum of the asset.'''
        with get(self.url) as stream:
            return sha256(stream)

    def __str__(self):
        return self.name


class Formula:
    '''A formula in the homebrew tap.'''

    SOURCE_DIR = FORMULA_SOURCE_DIR
    TARGET_DIR = FORMULA_TARGET_DIR

    def __init__(self, name):
        self.name = name

    @staticmethod
    def discover():
        '''Discover all available formulas.'''
        files = glob.glob(os.path.join(FORMULA_SOURCE_DIR, '*.json'))
        return [os.path.basename(x.removesuffix('.json')) for x in files]

    def sync(self, force=False):
        '''Synchronize the formula with the latest release.'''
        if not force and self.version == self.target_version:
            logging.debug('%s: already up-to-date', HL(self))
            return
        logging.info('Updating %s to version %s', HL(self), HL(self.version))
        release = self.repo.release(self.version).resolved
        version = release.version
        assets = self.assets(release.name)
        params = {
            'VERSION': version,
            **{f'ASSET_{x.os.upper()}_{x.arch.upper()}_URL': x.url for x in assets},
            **{f'ASSET_{x.os.upper()}_{x.arch.upper()}_SHA256': x.sha256 for x in assets},
            'REPOSITORY_URL': self.repo_url+'.git',
            'HEAD_BRANCH': self.head_branch,
        }
        script = render(read(self.template), **params)
        write(self.target_file, script)

        if not self.local_repo.is_clean and self.local_repo.is_clean_except(self.target_file, self.spec_file):
            self.make_pull_request()

    def make_pull_request(self):
        '''Make a pull request for the formula.'''
        repo = self.local_repo
        base = repo.current_branch
        if not base:
            base = repo.current_commit
        branch = f'update-{self.name}-{self.version}'
        repo.create_branch(branch)
        repo.add(self.target_file, self.spec_file)
        repo.commit(f'{self.name}: update to {self.version}')
        repo.push(branch)
        repo.checkout(base)
        self.open_pull_request(branch, base)

    def open_pull_request(self, head, base):
        '''Open a pull request for the formula.'''
        url = f'{UPSTREAM_REPO}/compare/{base}...{head}'
        run(['open', url])

    @property
    def local_repo(self):
        '''Get the local git repository for the formula.'''
        return LocalGitRepo('.')

    @cached_property
    def repo(self):
        '''The GitHub repository for the formula.'''
        try:
            info = urllib.parse.urlparse(self.repo_url)
            if info.scheme != 'https':
                raise ValueError(f'Unsupported scheme {HL(repr(info.scheme))}')
            if info.netloc != 'github.com':
                raise ValueError(f'Unsupported host: {HL(repr(info.netloc))}')
            parts = info.path.strip('/').split('/')
            if len(parts) != 2:
                raise ValueError(f'Invalid path: {HL(repr(info.path))}')
        except Exception as e:
            raise ValueError(f'Invalid repository URL {HL(repr(self.repo_url))} for {self}: {e}') from e
        return GitHubRepo(*parts)

    @normalized_release_ref
    @functools.lru_cache(maxsize=16)
    def assets(self, release='latest'):
        '''Get the assets of the formula for the given release.'''
        release = self.repo.release(release).resolved
        return [FormulaAsset(self, spec, release) for spec in self.spec['assets']]

    @property
    def version(self):
        '''The version of the formula.'''
        return self.spec['version']

    @property
    def version_tag(self):
        '''The version tag for the formula.'''
        return f'v{self.version}'

    @property
    def target_version(self):
        '''The target version of the formula.'''
        pattern = re.compile(r"^\s*version\s+\"([\da-zA-Z\.]+)\"$")
        for line in read(self.target_file).splitlines():
            match = pattern.match(line)
            if match:
                return match.group(1)
        command = ['brew', 'info', '--formula', '--json', os.path.join('.', self.target_file)]
        data = json.loads(output(command))
        return data[0]['versions']['stable']

    @property
    def repo_url(self):
        '''The repository URL for the formula.'''
        return self.spec['repository']['url']

    @property
    def head_branch(self):
        '''The main branch of the repository.'''
        return self.spec['repository']['branch']

    @property
    def source_archive_url(self):
        '''The source archive URL for the formula.'''
        return f'{self.repo_url}/archive/refs/tags/{self.version_tag}.tar.gz'

    @cached_property
    def source_archive_sha256(self):
        '''The SHA-256 checksum of the source archive.'''
        with get(self.source_archive_url) as stream:
            return sha256(stream)

    @cached_property
    def spec(self):
        '''The specification for the formula.'''
        return json.loads(read(self.spec_file))

    @property
    def spec_file(self):
        '''The specification file for the formula.'''
        return f'{self.SOURCE_DIR}/{self.name}.json'

    @property
    def target_file(self):
        '''The target file for the formula.'''
        return f'{self.TARGET_DIR}/{self.name}.rb'

    @property
    def template(self):
        '''The template file for the formula.'''
        return f'{self.SOURCE_DIR}/{self.name}.rb.tpl'

    def __str__(self):
        return HL(self.name)

    def __eq__(self, other):
        return self.name == other.name

    def __hash__(self) -> int:
        return hash(self.name)

class MultiFormatter(logging.Formatter):
    '''A multi-line formatter for the log output.'''

    def __init__(self, fallback: logging.Formatter, formatters: typing.Mapping[int, logging.Formatter]):
        super().__init__()
        self._fallback = fallback
        self._formatters = formatters

    def format(self, record):
        formatter = self._formatters.get(record.levelno, self._fallback)
        return formatter.format(record)


def sync(args):
    '''Synchronize the homebrew tap with the source code.'''
    formulas = list(args.formula)
    if not formulas:
        formulas = Formula.discover()
    for formula in map(Formula, formulas):
        formula.sync(force=args.force)


def setup_logging(level: int = logging.INFO):
    '''Set up the logging.'''
    if level < logging.INFO:
        logging.addLevelName(logging.DEBUG, MAGENTA('DBG'))
        logging.addLevelName(logging.INFO, GREEN('INF'))
        logging.addLevelName(logging.WARNING, YELLOW('WRN'))
        logging.addLevelName(logging.ERROR, RED('ERR'))
        fmt = f'{FAINT("%(asctime)s")} %(levelname)s %(message)s'
        formatter = logging.Formatter(fmt, datefmt='%H:%M:%S')
    else:
        formatter = MultiFormatter(
            logging.Formatter('%(message)s'),
            {
                logging.WARNING: logging.Formatter(f'{YELLOW("WARNING:")} %(message)s'),
                logging.ERROR: logging.Formatter(f'{RED("ERROR:")} %(message)s'),
            }
        )
    handler = logging.StreamHandler(stream=sys.stdout)
    handler.setFormatter(formatter)
    logger = logging.getLogger()
    logger.setLevel(level)
    logger.addHandler(handler)


def setup_cli_command_sync(group):
    '''Set up the 'sync' command.'''
    command = group.add_parser('sync', help='Synchronize the homebrew tap with the source code')
    command.add_argument('--force', '-f', action='store_true', default=False,
                         help='Force the synchronization even if formulas are up-to-date')
    command.add_argument('formula', nargs='*', help='The list of formulas to synchronize')
    command.set_defaults(func=sync)


def setup_cli():
    '''Set up the command-line interface.'''
    root = argparse.ArgumentParser(description='Manage the homebrew tap')
    root.add_argument('--verbose', '-v', action='store_const', dest='level', const=logging.DEBUG,
                      help='Enable the verbose mode')
    root.add_argument('--quiet', '-q', action='store_const', dest='level', const=logging.WARNING,
                      help='Enable the quiet mode')
    root.add_argument('--no-color', action='store_const', dest='color', const='never',
                      help='Disable the ANSI color output')
    root.add_argument('--color', action='store_const', dest='color', const='always',
                      help='Enable the ANSI color output')
    root.set_defaults(color='auto')
    root.set_defaults(level=logging.INFO)
    root.set_defaults(func=lambda _: root.print_help())
    group = root.add_subparsers()
    setup_cli_command_sync(group)

    return root


def setup_color(color):
    '''Set up the color output.'''
    if color.lower() == 'never':
        os.environ['NO_COLOR'] = '1'
    elif color.lower() == 'always':
        os.environ['NO_COLOR'] = '0'
    elif not sys.stdout.isatty():
        os.environ['NO_COLOR'] = '1'


def main():
    '''Main entry point for the CLI.'''
    args = setup_cli().parse_args()
    setup_color(args.color)
    setup_logging(args.level)
    args.func(args)


if __name__ == '__main__':
    def error(message):
        '''Print the error message and exit.'''
        print(f'{BOLD.plus(RED.fg)("ERROR:")} {message}')
        sys.exit(1)
    try:
        main()
    except urllib.request.HTTPError as err:
        error(f'Failed to get {err.url}: {err.code}')
    except RuntimeError as err:
        error(err)
    except ValueError as err:
        error(err)
    except FileNotFoundError as err:
        error(f'File not found: {err.filename}')
    except subprocess.CalledProcessError as err:
        error(f'Command {HL("`"+shlex.join(err.cmd)+"`")} failed with exit code {RED(err.returncode)}')
