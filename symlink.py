import pathlib


def is_child(child, parent):
  try:
    child.relative_to(parent)
    return True
  except ValueError:
    return False


def remove_broken_links(repo, user):
  # Only search in one level into directories that are mirrored in the
  # repository and only report broken links that point to the repository. It's
  # good to be careful because links in mounted network drives may seem broken
  # for the client.
  for directory in repo.glob('**/*'):
    if not directory.is_dir():
      continue
    for path in (user / directory.relative_to(repo)).glob('*'):
      target = path.resolve()
      if is_child(target, repo) and not target.exists():
        print('Broken:', path)
        path.unlink()


def create_links(repo, user):
  for path in repo.glob('**/*'):
    dest = user / path.relative_to(repo)
    if path.is_dir():
      dest.mkdir(exist_ok=True)
      continue
    if not dest.exists():
      print('Create:', dest, '->', path)
      dest.symlink_to(path)
      continue
    if dest.is_symlink() and is_child(dest.resolve(), repo):
      if dest.resolve() != path:
        message = f'Expected existing {dest} to resolve to {path} '
        message += f'but resolved to {dest.resolve()} instead.'
        raise RuntimeError(message)
      continue
    print('Exists:', dest)


def main():
  repo = (pathlib.Path(__file__).parent / 'home').resolve()
  user = pathlib.Path('~').expanduser().resolve()
  remove_broken_links(repo, user)
  create_links(repo, user)
  print('Done.')


if __name__ == '__main__':
  main()
