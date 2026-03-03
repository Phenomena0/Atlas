# Prometheus Rule Evaluation Failures

## Symptom
- **Alert:** `PrometheusRuleEvaluationFailures`

## Meaning
One or more Prometheus recording or alerting rules failed to evaluate. This means:
- Derived metrics may be stale or missing
- Alerts that depend on failed rules will not fire (silent failures)

## Triage
1. Open the Prometheus UI: `http://localhost:9090/rules`
2. Look for rules in an **error** state — the error message will identify the broken expression
3. Check for label cardinality issues or missing metrics that the rule depends on
4. Check Prometheus logs: `docker logs atlas-prometheus`

## Common causes
- A recording rule references a metric that no longer exists (e.g. exporter updated)
- PromQL syntax error introduced in a rules file
- Label mismatch between a recording rule and the alert that consumes it

## Mitigation
1. Identify the failing rule from the Prometheus UI
2. Validate all rules locally: `promtool check rules rules/*.yml`
3. Fix the expression and redeploy: `.\scripts\deploy.ps1`

## Prevention
- Run `promtool check rules` in CI before merging any rules changes
