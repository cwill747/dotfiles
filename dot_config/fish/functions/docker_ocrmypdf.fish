function docker_ocrmypdf --wraps='docker run --rm ocrmypdf' --description 'alias docker_ocrmypdf docker run --rm ocrmypdf'
  docker run --rm ocrmypdf $argv
        
end
