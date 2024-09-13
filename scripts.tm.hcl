script "checks" {
  description = "Run trivy"

  job {
    commands = [
      ["trivy", "config", "--severity", "CRITICAL,HIGH,MEDIUM", "."]
    ]
  }
}
