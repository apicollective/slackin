# Generic template chart

## Chart configuration - values.yaml

This chart allows the following values to be overridden:

Parameter|Description|Default
---------|-----------|-------
`nameOverride`|Replaces the name of the chart in Chart.yaml, when this is used to construct Kubernetes object names.|`None`
`fullnameOverride`|It comepletely replaces the generated name|`None`
`team`|The microservice owning team's name|`None`
`service.nameOverride`|Replaces the default service name|`None`
`service.port`|Container port that microservice is bound to|`9000`
`service.httpsPort`|HTTPS container port that microservice is bound to|`None`
`service.startupHealthcheckEndpoint`| k8s startup probe path to access on the microservice|`service.healthcheckEndpoint`
`service.livenessHealthcheckEndpoint`| k8s liveness probe path to access on the microservice|`service.healthcheckEndpoint`
`service.readinessHealthcheckEndpoint`| k8s readiness probe path to access on the microservice|`service.healthcheckEndpoint`
`service.healthcheckEndpoint`|k8s healthcheck probes path to access on the microservice|`/_internal_/healthcheck`
`iamRole`|IAM Role used by microservice|`None`
`image.repository`|Container image repository|`None`
`image.pullPolicy`|Container image pull policy|`IfNotPresent`
`image.args`|The microservice container args|`production`
`imagePullSecrets`|Container registry image pull secret|`flow-docker-hub`
`resources.requests.cpu`|CPU usage _request_.|`None`
`resources.requests.memory`|Memory usage _request_.|`None`
`resources.limits.cpu`|CPU usage _limit_.|`None`
`resources.limits.memory`|Memory usage _limit_.|`None`
`jvmOpts.enabled`|Enable JAVA_OPTS|`true`
`jvmOpts.memory`|JVM Memory set in JAVA_OPTS via `-Xms{{ .memory }} -Xmx{{ .memory }}`|`None`
`jvmOpts.extraArgs`|JAVA_OPTS Extra args|`-XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/opt -XX:+UseG1GC -XX:+UseStringDeduplication`
`affinity.enabled`|The pod anti affinity rule to spread evenly across zones|`false`
`nodeSelector`|Will ensure that Pod will only deploy on node(s) with corresponding labels and values.|`None`
`tolerations`|Enables the Pod to be deployed on a tainted node matching all keys and values specified. The values must be in yaml list form.|`None`
`topologySpreadConstraints.enabled`| topology spread constraints helps to control how Pods are spread across your cluster among failure-domains such as regions, zones, nodes, and other user-defined topology domains|`true`
`istioIngress.enabled`|Enables istio istioIngress gateway|`true`
`istioIngress.defaultCFProxy`|Enables Cloudflare orange cloud for default gateways|`true`
`istioIngress.authorizationPolicy.ipBlocks.action`|istio authorization policy Action|`ALLOW`
`istioIngress.authorizationPolicy.dryRun`|istio authorization policy dry-run mode|`false`
`istioIngress.authorizationPolicy.ipBlocks.ipList`|istio authorization policy list of IPs to be actioned on|`None`
`istioIngress.authorizationPolicy.ipBlocks.hosts`|istio authorization policy list of hosts to be actioned on|`None`
`istioIngress.gateways.key`|istio gateway resource name|`None`
`istioIngress.gateways.tld`|istio gateway domain, for example: `api.flow.io`, `flo.pub`|`None`
`istioIngress.gateways.selector`|istio gateway label sector, in pci environment flo.pub gateway is labelled as `ingressgateway-private`|`ingressgateway`
`istioIngress.gateways.dns`|This flag ensures that the relevant hosts CNAME record is created in Cloudflare automatically.|`None`
`istioIngress.gateways.proxied`|This flag toggles the orange cloud / proxy in Cloudflare.|`false`
`istioIngress.gateways.hosts`|istio gateway host FQDN accessible.|`None`
`istioService.live.hosts`|istio virtual service configuration - Destinatin hosts to which traffic is sent|`None`
`istioService.live.gateways`|istio virtual service configuration - Names of gateways and sidecars that should apply these routes.|`None`
`istioService.live.lbAlgorithm`|istio destination rule load balancer algorithm. More details [here](https://istio.io/latest/docs/reference/config/networking/destination-rule/#LoadBalancerSettings-SimpleLB)|`ROUND_ROBIN`
`istioService.idleTimeoutOverride`|Override the Destination rule http connection pool idleTimeout.|`false`
`istioService.idleTimeoutValue`|The Destination rule http connection pool idleTimeout.|`70s`
`istioService.stages.deployment`|istio virtual service configuration - Subset a.k.a Service versions|`live`
`istioService.stages.weight`|istio virtual service configuration - Primary route destination weight. Weights associated with the service version determine the proportion of traffic it receives|`100`
`istio.logLevel`|istio proxy log level. Set to `debug` for troubleshooting/debugging any proxy sidecar issues.|`info`
`istio.agentLogEnabled`|Enable istio pilot-agent log|`false`
`istio.agentLogLevel`|Specifies the log output level for pilot-agent. Level can be: trace, debug, info, warning, error, critical, off|`info`
`istio.terminationDrainDuration`|The amount of time allowed for connections to complete on proxy shutdown. On receiving SIGTERM or SIGINT, istio-agent tells the active Envoy to start draining, preventing any new connections and allowing existing connections to complete|`30s`
`istio.alb`|Istio alb ingressgateway|`false`
`istio.albApiTarget`|Istio alb api.flow.io ingressgateway load balancer target|`none`
`istio.albFlowioTarget`|Istio alb flow.io ingressgateway load balancer target|`none`
`istio.albFlowpubTarget`|Istio alb flo.pub ingressgateway load balancer target|`none`
`istio,albDarkTarget`|Istio alb dark.flow.io ingressgateway load balancer target|`none`
`istio.albApibuilderTarget`|Istio alb apibuilder.io ingressgateway load balancer target|`none`
`deployments.live.env`|Live deployment extra environment variables. List of `name`/`value` pairs.|`None`
`deployments.live.minReplicas`|Defines the replica count for the live deployment. It also sets the minimum Replicas for Horizontal Pod Autoscaler configuration(HPA). HPA is currently disabled but this defines the replica count for a deployment|`1`
`deployments.live.maxReplicas`|Live deployment maximum Replicas for HPA. HPA is currently disabled.|`1`
`deployments.live.maxUnavailable`|How many Pod replicas can be unavailable _during deploy_.|`0`
`deployments.live.disruptionBudgetEnabled`|Configures a [PodDisruptionBudget](https://kubernetes.io/docs/concepts/workloads/pods/disruptions/) for the minimum number (or percentage) of pods required to be alive during a planned maintenance event (like a node removal)|`true`
`deployments.live.targetCPUUtilizationPercentage`|CPU utlization threshold defined in HPA configuration|`80`
`deployments.live.version`|The container image tag. It is dynamically set in the Jenkins pipeline helm deployment method.|`None`
`deployments.live.serviceAccountName`|Serviceaccount name bound to the deployment|`None`
`deployments.live.serviceAccountIamRole`|AWS IAM role configured for the serviceaccount|`None`
`deployments.live.strategy`|This sets the deployment [Strategy](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy)|`RollingUpdate`
`deployments.live.maxSurge`|This specifies the maximum number of Pods that can be created over the desired number of Pods.|`1`
`deployments.live.terminationGracePeriodSeconds`| The maximum time to shutdown the containers after SIGTERM is passed.|`60s`
`deployments.live.globalSecurityContext`|globalSecurityContext holds pod-level security attributes and common container settings. Some fields are also present in containerSecurityContext. Field values of containerSecurityContext take precedence over field values of globalSecurityContext.|`None`
`deployments.live.containerSecurityContext`|containerSecurityContext holds security configuration that will be applied to a container. Some fields are present in both SecurityContext and globalSecurityContext. When both are set, the values in containerSecurityContext take precedence.|`None`
`rollout.enabled`|Enables the Argo [Rollout](https://argoproj.github.io/argo-rollouts/features/specification/) resource. To revert to k8s deployment resource disable this flag.|`false`
`rollout.migration`|Migration flag to be enabled for the first time when moving to Canary deployment strategy. This ensures that the deployment resource runs alongside the Rollout resource.|`false`
`rollout.strategy`|Update strategy, like blue-green, canary|`canary`
`rollout.enableDynamicScale`|Dynamically scale the stable/live ReplicaSet according to traffic weight|`false`
`rollout.notificationChannel`|Argo Rollout Notifications are subscribed to this Slack Channel.|`deploys`
`rollout.revisionHistoryLimit`|Canary release revision history. The number of old ReplicaSets to retain.|`5`
`rollout.progressDeadlineSeconds`|The maximum time in seconds in which a rollout must make progress during an update, before it is considered to be failed. Argo Rollouts will continue to process failed rollouts and a condition with a ProgressDeadlineExceeded reason will be surfaced in the rollout status. Note that progress will not be estimated during the time a rollout is paused.|`900`
`rollout.progressDeadlineAbort`|Abort the update when ProgressDeadlineSeconds is exceeded.|`true`
`rollout.steps`|Define a list of steps the Argo Rolloutscontroller uses to manipulate the ReplicaSets when there is a change to the .spec.template. Each step will be evaluated before the new ReplicaSet is promoted to the stable version, and the old version is completely scaled down. Each step can have one of two fields. The setWeight field dictates the percentage of traffic that should be sent to the canary, and the pause struct instructs the rollout to pause.|`None`
`rollout.defaultAnalysis.erroRate.enabled`|Enable the built-in error rate datadog analysis query|`false`
`rollout.defaultAnalysis.errorRate.successCondition`|The condition to evaluate the query result|`None`
`rollout.defaultAnalysis.errorRate.failureLimit`|The failure threshold|`0`
`rollout.defaultAnalysis.erroRate.interval`|Analysis query interval|`1m`
`rollout.defaultAnalysis.errorRate.filters`|Additional boolean Datadog metric filters, eg. `resource_name:foo OR resource_name:bar`|`None`
`rollout.defaultAnalysis.errorRate.provider.datadog.interval`|Datadog analysis query interval|`1m`
`rollout.defaultAnalysis.errorRate.provider.datadog.query`|Datadog analysis query|`sum:trace.akka_http.request.errors{service:<service-name>,version:<image-tag>}.as_count() / sum:trace.akka_http.request.hits{<service-name>,version:<image-tag>}.as_count()`
`rollout.defaultAnalysis.{p50 or p95 or p99}ResponseTime.successCondition`|The condition to evaluate the query result|`None`
`rollout.defaultAnalysis.{p50 or p95 or p99}ResponseTime.failureLimit`|The failure threshold|`0`
`rollout.defaultAnalysis.{p50 or p95 or p99}ResponseTime.interval`|Analysis query interval|`1m`
`rollout.defaultAnalysis.{p50 or p95 or p99}ResponseTime.filters`|Additional boolean Datadog metric filters, eg. `resource_name:foo OR resource_name:bar`|`None`
`rollout.defaultAnalysis.{p50 or p95 or p99}ResponseTime.provider.datadog.interval`|Datadog analysis query interval|`1m`
`rollout.defaultAnalysis.{p50 or p95 or p99}ResponseTime.provider.datadog.query`|Datadog analysis query|`{p50 or p95 or p99}:trace.akka_http.request{<service-name>,version:<image-tag>}`
`rollout.analysis.name`|Additional Metrics|`None`
`rollout.analysis.interval`|Analysis interval|`1m`
`rollout.analysis.errorRate.successCondition`|The condition to evaluate the query result|`None`
`rollout.analysis.errorRate.failureLimit`|The failure threshold|`0`
`rollout.analysis.erroRate.interval`|Analysis query interval|`1m`
`rollout.analysis.errorRate.provider.datadog.interval`|Datadog analysis query interval|`1m`
`rollout.analysis.errorRate.provider.datadog.query`|Datadog query|`None`
`rollout.jobAnalysis.name`|Name of the job container|`None`
`rollout.jobAnalysis.interval`|Job analysis interval. Example: 5s|`None`
`rollout.jobAnalysis.failureLimit`|The job failure threshold|`0`
`rollout.jobAnalysis.backoffLimit`|The job pod failure tolerance|`0`
`rollout.jobAnalysis.image`|The job container image|`None`
`rollout.jobAnalysis.imagePullSecrets`|Job container image pull secret|`flow-docker-hub`
`rollout.jobAnalysis.command`|List of job container command args. Example: ["sbt", "test"]|`None`
`rollout.jobAnalysis.env`|Environment variables to be used by the job container|`None`
`rollout.analysisStartingStep`|Delay starting analysis run until the specified step as defined in `rollout.steps`|`1`
`datadogMonitors.type`| Defines the type of monitor that will be created, options are: trace.akka_http.request-avg, trace.hapi.request-avg,  trace.akka_http.request.errors-sum, trace.akka_http.request-p95, trace.akka_http.request-p99, flow.lib_postgres_play.db.journal_queue.lag_ms-avg, flow.lib_postgres_play.db.failure_queue.length-avg and flow.lib_event.kinesis.consumer.lagMillis-avg, trace.akka_http.request.hits-anomaly-low, custom-query  |`None`
`datadogMonitors.query`| Defines the query used in the monitor, only applicable to custom-query type of monitors  | `None`
`datadogMonitors.name`| Defines the interval name applied when using multiple monitors using same metric | ``
`datadogMonitors.monitorMainOperator`| Defines the main group operator used in the monitor, min/max/avg/.... | `depends on the monitor type`
`datadogMonitors.interval`| Defines the interval for the monitor |`last_10m`
`datadogMonitors.filters`|Additional boolean Datadog metric filters, eg. `resource_name:foo OR resource_name:bar`|`None`
`datadogMonitors.alert.threshold`| Defines the critical threshold for the monitor |`0.05`
`datadogMonitors.alert.newGroupDelay`| Defines the delay to start alerting for new groups, only applicable to multi_alert monitors |`600`
`datadogMonitors.alert.notificationTarget`| Defines the notification for the critical threshold in monitor |`@pagerduty-<team>`
`datadogMonitors.warning.threshold`| Defines the critical threshold for the monitor |`0.04`
`datadogMonitors.warning.notificationTarget`| Defines the notification for the warning threshold in monitor |`@slack-team-<team>-notifications`
`datadogMonitors.comment`| Defines the comment or message shown in the alert for the monitor |`None`

## Chart Migration

This [page](https://www.notion.so/flow/Migrating-to-Generic-Charts-5f87034464fe40d388acf76f91c02968#72738c1504464c5497cab0f5c99583f7) illustrates the chart migration procedure from a pre-existing chart to generic chart.

## Canary Migration

The migration procedure is described [here](https://www.notion.so/flow/Migrating-to-Generic-Charts-5f87034464fe40d388acf76f91c02968#7d00d5c7f11d433887fbfc64236bc41f)

## Chart Repository

[Jfrog Artifactory](https://flow.jfrog.io/) is the chosen helm chart repository. The repository in use is called `generic-charts-helm`.

Whenever the `Chart.yaml` version is updated in the `main` branch, the Jenkins pipeline packages and uploads the new chart version to the helm repository.

The microservices will need `requirements.yaml` (helm v1) and `values.yaml` files under the `deploy/<microservice/>` path that will be used by the [helmCommonDeploy](https://github.com/flowcommerce/lib-jenkins-pipeline/blob/main/vars/helmCommonDeploy.groovy) method in the microservice Jenkinsfile.

The `requirements.yaml` example is as below:

```dependencies:
  - name: flow-generic
    version: ^1.0.0
    repository: https://flow.jfrog.io/artifactory/api/helm/generic-charts-helm
```
