# Operations Guide

This guide describes how to monitor, troubleshoot, and recover the Health Check API running on the Azure Linux VM.

## 1. Check Service Status

Connect to the VM over SSH and check the systemd service:

```bash
sudo systemctl status health-check-api
```

Verify that the service is enabled to start automatically after reboot:

```bash
sudo systemctl is-enabled health-check-api
```

## 2. Check Application Logs

View the most recent application logs:

```bash
sudo journalctl -u health-check-api -n 100 --no-pager
```

Follow logs in real time:

```bash
sudo journalctl -u health-check-api -f
```

Look for application errors, startup failures, missing dependencies, or port-binding issues.

## 3. Verify API Health

Check the health endpoint locally on the VM:

```bash
curl -i --max-time 5 http://127.0.0.1:8000/health
```

A healthy response should return HTTP 200 with JSON containing `"status": "healthy"` and a timestamp.

Test the root endpoint:

```bash
curl -i http://127.0.0.1:8000/
```

## 4. Check Automated Health Monitoring

The scheduled health-check script runs every five minutes. It checks the `/health` endpoint and attempts to restart the service if the endpoint is unhealthy.

View health-monitoring logs:

```bash
sudo journalctl -t health-check-api --since "1 hour ago"
```

Follow new health-monitoring messages:

```bash
sudo journalctl -t health-check-api -f
```

The script logs failures and recovery attempts. Successful checks do not generate log messages.

## 5. Restart the Service

If the API is unhealthy, restart it manually:

```bash
sudo systemctl restart health-check-api
```

Check the service status and verify recovery:

```bash
sudo systemctl status health-check-api
curl -i http://127.0.0.1:8000/health
```

systemd automatically restarts the application process if it exits. The scheduled health check provides an additional layer of HTTP-level failure detection.

## 6. Troubleshoot Network Access

If the API works locally but is inaccessible externally:

1. Confirm the VM's public IP address.
2. Check that the application is listening on port 8000.
3. Review the Azure Network Security Group rules.
4. Confirm that inbound HTTP traffic on port 8000 is allowed.
5. Verify that SSH access on port 22 remains restricted to the intended IP ranges.

Check listening ports:

```bash
sudo ss -lntp
```

Do not expose SSH to all source IPs as a troubleshooting shortcut.

## 7. Troubleshoot Deployment

If a deployment fails, open GitHub Actions and inspect the relevant workflow run.

- **Code Validation:** Review dependency installation and pytest results.
- **Terraform and Ansible Deployment:** Review Terraform execution, SSH connectivity, Ansible tasks, and the final health-check step.

After resolving the issue, rerun the appropriate workflow and verify that the API is healthy.

A failed post-deployment health check marks the workflow as failed; it does not automatically roll back the application or infrastructure.

## 8. Outage Response Checklist

1. Check the systemd service status.
2. Review application logs for errors.
3. Test `/health` locally on the VM.
4. Review health-monitoring logs.
5. Check port binding and Azure network rules.
6. Restart the service if necessary.
7. Verify recovery using the health endpoint.
8. Record the cause and resolution.
