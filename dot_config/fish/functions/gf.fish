function gf --description 'gf <url>' --argument url
  if test (count $url) -eq 0
    echo "Error: No URL provided."
    return 1
  end

  set tempdir (mktemp -d /tmp/$1.XXXX)
  if test $status -ne 0
    echo "Error: Failed to create temp directory"
    return 1
  end

  set filename (basename "$url")
  set output "$tempdir/$filename"

  curl -s -L -o $output $url
  if test $status -ne 0
    echo "Error: failed to download file"
    return 1
  end

  echo $output
end
