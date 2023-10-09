function bprf
  set upstreambranch "origin/release/$relbranch"
  set base "release/$relbranch"
  if not git branch -r --list | grep -q $upstreambranch
    echo "Project doesn't use slashes, checking dashes"
    set upstreambranch "origin/release-$relbranch"
    set base "release-$relbranch"
  end
  echo "Set upstream branch to $upstreambranch"
  git cherry-pick --continue
  set commit_title (git log -1 --pretty=format:%s)
  set commit_body (git log -1 --pretty=format:%B)
  set pr_title "main->$relbranch: $commit_title"
  set pr_title (string trim --chars 60 $pr_title)
  gh pr create --title "$pr_title" --base "$base"
  set -e relbranch
end
