workflow "ci" {
  on = "push"
  resolves = [
    "bootstrap with jessie",
    "build tmquick"
  ]
}

action "bootstrap with jessie" {
  uses = "docker://debian:jessie"
  runs = "./bootstrap.sh"
}

action "build tmquick" {
  uses = "actions/docker/cli@master"
  args = [
    "build",
    "tmquick"
  ]
}
