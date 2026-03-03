# Prometheus / Alertmanager Config Reload Failed

## Symptom
- **Alert:** `PrometheusConfigReloadFailed` or `AlertmanagerConfigReloadFailed` or `AlertmanagerNotificationsFailed`

## Meaning
A component reloaded its config (via SIGHUP or `/-/reload`) and the reload failed. The component is **running on its previous configuration** — rule changes or routing changes have not taken effect.

For `AlertmanagerNotificationsFailed`: notifications are being generated but delivery to the receiver (email) is failing.

## Triage

### Prometheus config reload
1. Check Prometheus logs: `docker logs atlas-prometheus`
2. Validate the config: `promtool check config prometheus.yml`
3. Verify all referenced rule files and target files exist and are mounted correctly

### Alertmanager config reload
1. Check Alertmanager logs: `docker logs atlas-alert`
2. Verify the rendered config exists: `docker exec atlas-alert cat /etc/alertmanager-rendered/alertmanager.yml`
3. Validate: `amtool check-config /etc/alertmanager-rendered/alertmanager.yml`
4. Check `atlas-alert-render-config` container exited successfully: `docker ps -a | grep render`

### Alertmanager notification failures
1. Check SMTP credentials in `.secrets.env` (`ALERTMANAGER_SMTP_PASSWORD`)
2. Check `ALERTMANAGER_SMTP_HOST` is reachable from the control-plane host
3. Verify `WATCHDOG_PING_URL` is valid and reachable (for watchdog receiver)
4. Check Alertmanager logs for the specific integration error: `docker logs atlas-alert`

## Mitigation
1. Fix the config error
2. Redeploy: `.\scripts\deploy.ps1`
3. Or trigger a hot reload: `curl -X POST http://localhost:9090/-/reload` (Prometheus) or `http://localhost:9093/-/reload` (Alertmanager)
