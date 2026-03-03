# SLO Slow Burn

## Symptom
- **Alert:** `SLOBurnRateSlow` (warning) or `SLOBurnRateTrend` (info)

## Meaning

| Alert | Burn rate | Window | Implication |
|---|---|---|---|
| `SLOBurnRateSlow` | >6x budget | 6h / 30m | Budget exhausted in ~7 days |
| `SLOBurnRateTrend` | >1x budget | 3d / 6h | On track to breach monthly SLO |

Unlike `SLOBurnRateFast`, this is **not an incident** — but it requires investigation before it becomes one. The service is degraded or intermittently failing at a rate that will consume the full error budget before month end.

## Triage
1. Identify which service is burning: check `service` label on the alert
2. Open the Synthetic dashboard in Grafana and look for intermittent probe failures or elevated latency
3. Check container logs in Grafana / Loki for the affected service
4. Look for patterns: time-of-day, specific endpoints, correlation with Plex transcodes or parity checks

## Mitigation
1. Fix the root cause if identified (restart, resource limits, dependency issues)
2. If intermittent and unexplained, add TCP probe alongside HTTP to narrow down network vs application
3. If the burn rate normalises, the alert will resolve automatically

## Post-incident
- If the SLO was breached, document it
- Consider tightening the probe interval or adding additional probe modules for the affected service
- Review whether the 99.5% SLO target is appropriate for the service
