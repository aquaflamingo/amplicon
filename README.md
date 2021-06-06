# GitPort

Hosted Biochemistry

## What is GitPort?
GitPort is a biochemistry lab hosting application. In the objective of GitPort is to become a central repository for bio-engineering practitioners and researchers to:

1. Host, version control and collaborate on homegrown laboratory protocols publicly or privately with other contributors
2. Discover new laboratory protocols, tools, and methods which enable them to work on projects they work on

## How does GitPort work?
GitPort users create GitPort repositories which are version controlled by `git` under the hood. An GitPort repository represents a particular resource which dictates it's structure and requirements. In other words, a repository has a resource type which opinionates the `git` repository structure under the hood.

### Protocol Resource
Initially, there is only one type of resource: `protocol`, which is a laboratory protocol. A protocol is a collection of instructions, materials and methods that tell someone how to perform a particular biochemical experiment, assay or process.

A protocol's `git` repository contains three folders: `materials`, `methods`, and `reagents`. Each folder contains markdown content which is rendered through the GitPort webapp.

## TODO
* Describe Organization
* Describe Private vs. Public Repositories
* Describe Rendering Algorithm for Resources
* `git push` to upload 
* API Keys
