workflow "ci" {
  on = "push"
  resolves = "bootstrap with jessie"
}

action "bootstrap with jessie" {
  uses = "docker://debian:jessie"
  runs = "./bootstrap.sh"
}
