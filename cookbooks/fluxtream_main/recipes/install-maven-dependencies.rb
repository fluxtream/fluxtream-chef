
execute "install maven dependencies" do
  command "/home/fluxtream/projects/fluxtream-app/maven/install.sh"
  cwd "/home/fluxtream/projects/fluxtream-app/maven"
  user "fluxtream"
end