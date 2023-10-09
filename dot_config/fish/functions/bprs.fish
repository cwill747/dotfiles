function bprs --description 'bprs <release_name> <commit>'
  set -gx relbranch $argv[1]
  git fetch
  set upstreambranch "origin/release/$relbranch"
  if not git branch -r --list | grep -q $upstreambranch
    echo "Project doesn't use slashes, checking dashes"
    set upstreambranch "origin/release-$relbranch"
  end
  echo "Set upstream branch to $upstreambranch"
  set commit $argv[2]
  set shorthash (git rev-parse --short $commit)

  git branch "backport-$relbranch-$shorthash" "$upstreambranch"
  git checkout "backport-$relbranch-$shorthash"
  git -c merge.renameLimit=999999 cherry-pick --allow-empty -X ignore-all-space "$commit"
end
