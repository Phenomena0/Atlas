# Watchdog

## Symptom
- **Alert:** `Watchdog`
- This alert is **expected to fire continuously**. It is a dead man's switch.

## Meaning
The Watchdog alert exists to prove the full pipeline — Prometheus → Alertmanager → notification — is alive. It fires every minute and pings the configured dead man's switch URL (e.g. healthchecks.io).

If you **stop receiving** the regular Watchdog ping, something in the pipeline is broken.

## When this runbook is needed
You will only need this runbook if the Watchdog ping **stops arriving** at your dead man's switch.

## Triage
1. Check if Prometheus is running: `docker ps | grep atlas-prometheus`
2. Check Prometheus self-scrape: `http://localhost:9090/targets` — is `prometheus` UP?
3. Check Alertmanager is running: `docker ps | grep atlas-alert`
4. Check Alertmanager config loaded: `http://localhost:9093/#/status`
5. Verify `WATCHDOG_PING_URL` is set correctly in `.secrets.env`
6. Check Alertmanager logs: `docker logs atlas-alert`

## Mitigation
- Restart the affected component: `docker compose restart atlas-prometheus` or `atlas-alert`
- If config failed to render, re-run the deploy script: `.\scripts\deploy.ps1`
