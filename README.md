# kube-checker

Kube-checker extracts information of a running Kubernetes cluster to make debugging faster ane enabling support teams.

# Motivation

Debugging issues in a running Kubernetes cluster can become complex. Many of the issues can not be caught by existing logging/monitoring tools and technologies. Kube-checker codifies frequently used playbooks and provides the information at your fingertips so the resolution is faster.

There are some tools that exist but they solve a specific area only ATM. Kube-checker integrates will existing tools and fills gaps in areas where no tooling exist.

# Details

## Integrations

Following is list of tools that Kube-checker will integrate with to get information

| Tool Name | Details |
|--------|--------------------------------|
| [Klint](https://github.com/uswitch/klint)|Klint runs a linting rules against Kubernetes resources|
|[Node-problem-detector](https://github.com/kubernetes/node-problem-detector)|Node problem detector specifically focuses on problems at Node level and makes them visible upstream|
|[Kube-bench](https://github.com/aquasecurity/kube-bench)|Runs CIS Kubernetes benchmarks on a cluster|

## Rules/Playbooks

There are many things which are well documented from support perspective today but not “codified”, the Kube-checker fills that gap. For example, detecting that a job’s history has grown way too long and is consuming space is something most teams can do today by running a few commands, but can be handy if available as a one click utility and Kube-checker has many such utilities to enable faster remediation of problems. Some more sample rules that are part of Kube-checker:

- A pod should not use default service account and should use a custom service account instead.
- A pod should have resource requirement clearly defined (Supported by Klint as of now)
- A pod should have a security context defined.
- Using latest tag or no tag on a container image should be avoided, it makes it difficult to rollback and identify currently running version.
- Stopped containers on a node consuming space should be cleaned up periodically using garbage collection/some other mechanism.
- Checking if there are too many services of type “LoadBalancer”, creating equivalent public facing LBs in cloud provider and can be potentially replaced with an Ingress Controller


# Roadmap

# How to Contribute
