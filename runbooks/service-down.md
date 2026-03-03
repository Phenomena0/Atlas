# Service down (synthetic probe)

## Symptom
- **Alert:** `ServiceDown`

## Triage
- Confirm target is reachable from the BOH plane.
- Check the service container status on Unraid.
- Review recent logs in Grafana (Loki) for the service.

## Mitigation
- Restart the service container.
- If recurring, add resource limits and investigate root cause.
