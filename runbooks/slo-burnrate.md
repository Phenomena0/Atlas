# SLO Burn Rate (Fast)

## Symptom
- **Alert:** `SLOBurnRateFast`

## Meaning
The service is consuming its monthly error budget at >14x the sustainable rate. At this pace the full budget is exhausted in approximately **3 days**. Treat this as an active incident.

- For slow/trend burn alerts, see [`slo-slow-burn.md`](slo-slow-burn.md)

## Actions
1. Identify the affected service from the `service` label on the alert
2. Open the Synthetic dashboard in Grafana — look for probe failures or HTTP 5xx responses
3. Check container status on Unraid: `docker ps | grep <service>`
4. Review recent logs in Loki for the service
5. Restore availability (restart container, fix dependency, roll back recent change)
6. After mitigation, run a quick RCA and add prevention (resource limits, health checks, dependency hardening)
