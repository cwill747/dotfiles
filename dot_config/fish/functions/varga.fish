function varga
  git remote prune origin
  set before (git branch -vv | wc -l)
  git branch -vv | grep 'gone]' | awk '{ print $1}' | xargs git branch -D
  set after (git branch -vv | wc -l)
  set removed (math $before - $after)
  if [ $removed = 0 ]
      echo "I have removed no branches.  Why do I exist? ¯\_(ツ)_/¯"
  else
      echo "I have removed $removed branches.  I did good work today"
  end
end
