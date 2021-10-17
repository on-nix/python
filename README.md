# Python on Nix

Extensive collection
of [Python][PYTHON] projects
from the [Python Packaging Index][PYPI].
That can be used with the [Nix][NIX] package manager.

Check out the examples at [python.on-nix.com](https://python.on-nix.com/)!

- Scope:
  - :heavy_check_mark:
    All [active Python releases][PYTHON_RELEASES]
    (`3.6`, `3.7`, `3.8`, `3.9`, `3.10`)
  - :heavy_check_mark: 1700+ [projects][PROJECTS] already packaged,
    prioritized by their popularity
    according to [libraries.io](https://libraries.io/PyPI)
- Quality:
  - :heavy_check_mark: It is 100% Nix, with love :heart:
  - :heavy_check_mark: Data integrity checksums are used everywhere
  - :heavy_check_mark: We test projects before you use them
- Platforms:
  - :heavy_check_mark: Linux x86-64
  - :construction: MacOS x86-64
- Performance:
  - :heavy_check_mark: Every project is built with a minimal closure and size
  - :heavy_check_mark: A highly granular cache

Why?

To make using [Nix][NIX] on [Python][PYTHON] projects
as simple as possible!

Just:
1. Copy and paste the examples,
2. Select the [Python][PYTHON] projects of your choice,
3. Enjoy! :rocket:

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
# Contents

- [List of available projects](#list-of-available-projects)
- [Applications vs Libraries](#applications-vs-libraries)
- [Using with Nix stable](#using-with-nix-stable)
    - [Installing Applications](#installing-applications)
    - [Creating Python environments with Applications and Libraries](#creating-python-environments-with-applications-and-libraries)
        - [Compatibility with Nixpkgs](#compatibility-with-nixpkgs)
- [Using with Nix unstable (Nix Flakes)](#using-with-nix-unstable-nix-flakes)
    - [List of available projects](#list-of-available-projects-1)
    - [Trying out Applications without installing them](#trying-out-applications-without-installing-them)
    - [Installing Applications](#installing-applications-1)
    - [Creating Python environments with Applications and Libraries](#creating-python-environments-with-applications-and-libraries-1)
    - [Compatibility with Nixpkgs](#compatibility-with-nixpkgs-1)
- [Contributing](#contributing)
- [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# List of available projects

Additionally to the versions below,
there is a meta-version called `latest`
which points to the latest version of the project.

| Project | Version | Python Versions |
| ------- | :-----: | :-------------: |
| about-time | 3.1.1 | 3.6 3.7 3.8 3.9 |
| absl-py | 0.12.0 | 3.6 3.7 3.8 3.9 |
| absl-py | 0.13.0 | 3.6 3.7 3.8 3.9 |
| accesscontrol | 5.2 | 3.6 3.7 3.8 3.9 |
| access-points | 0.4.66 | 3.6 3.7 3.8 3.9 |
| acme | 1.19.0 | 3.6 3.7 3.8 3.9 |
| acquisition | 4.9 | 3.6 3.7 3.8 3.9 |
| adal | 1.2.7 | 3.6 3.7 3.8 3.9 |
| addict | 2.4.0 | 3.6 3.7 3.8 3.9 |
| aenum | 3.1.0 | 3.6 3.7 3.8 3.9 |
| affine | 2.3.0 | 3.6 3.7 3.8 3.9 |
| aioboto3 | 8.0.3 | 3.6 3.7 3.8 3.9 |
| aioboto3 | 9.2.0 | 3.7 3.8 3.9 |
| aiobotocore | 1.0.4 | 3.6 3.7 3.8 3.9 |
| aiobotocore | 1.3.3 | 3.7 3.8 3.9 |
| aiobotocore | 1.4.1 | 3.6 3.7 3.8 3.9 |
| aiocontextvars | 0.2.2 | 3.6 |
| aiodataloader | 0.2.0 | 3.6 3.7 3.8 3.9 |
| aiodns | 3.0.0 | 3.6 3.7 3.8 3.9 |
| aioextensions | 21.7.2261349 | 3.7 3.8 3.9 |
| aiofiles | 0.7.0 | 3.6 3.7 3.8 3.9 |
| aiogqlc | 1.0.5 | 3.6 3.7 3.8 3.9 |
| aiogqlc | 2.2.0 | 3.6 3.7 3.8 3.9 |
| aiohttp | 3.7.4.post0 | 3.6 3.7 3.8 3.9 |
| aiohttp-apispec | 2.2.1 | 3.6 3.7 3.8 3.9 |
| aiohttp-cors | 0.7.0 | 3.6 3.7 3.8 3.9 |
| aioitertools | 0.8.0 | 3.6 3.7 3.8 3.9 |
| aiomultiprocess | 0.9.0 | 3.6 3.7 3.8 3.9 |
| aiomysql | 0.0.21 | 3.6 3.7 3.8 3.9 |
| aio-pika | 6.8.0 | 3.6 3.7 3.8 3.9 |
| aioredis | 2.0.0 | 3.6 3.7 3.8 3.9 |
| aiormq | 3.3.1 | 3.6 3.7 3.8 3.9 |
| aiosqlite | 0.17.0 | 3.6 3.7 3.8 3.9 |
| alabaster | 0.7.12 | 3.6 3.7 3.8 3.9 |
| albumentations | 1.0.3 | 3.7 3.8 3.9 |
| alembic | 1.4.1 | 3.6 3.7 3.8 3.9 |
| alembic | 1.6.5 | 3.6 3.7 3.8 3.9 |
| alembic | 1.7.1 | 3.6 3.7 3.8 3.9 |
| alembic | 1.7.3 | 3.6 3.7 3.8 3.9 |
| alibabacloud-credentials | 0.1.4 | 3.6 3.7 3.8 3.9 |
| alibabacloud-credentials-py2 | 0.0.3 | 3.6 3.7 3.8 3.9 |
| alibabacloud-endpoint-util | 0.0.3 | 3.6 3.7 3.8 3.9 |
| alibabacloud-endpoint-util-py2 | 0.0.2 | 3.6 3.7 3.8 3.9 |
| alibabacloud-openapi-util | 0.1.5 | 3.6 3.7 3.8 3.9 |
| alibabacloud-tea | 0.2.8 | 3.6 3.7 3.8 3.9 |
| alibabacloud-tea-openapi | 0.2.7 | 3.8 3.9 |
| alibabacloud-tea-py2 | 0.0.3 | 3.6 3.7 3.8 3.9 |
| alibabacloud-tea-util | 0.3.5 | 3.6 3.7 3.8 3.9 |
| alibabacloud-tea-util-py2 | 0.0.5 | 3.6 3.7 3.8 3.9 |
| alive-progress | 2.0.0 | 3.6 3.7 3.8 3.9 |
| aliyun-python-sdk-core | 2.13.35 | 3.6 3.7 3.8 3.9 |
| alphalens | 0.4.0 | 3.6 3.7 3.8 3.9 |
| altair | 4.1.0 | 3.6 3.7 3.8 3.9 |
| amazon-dax-client | 2.0.0 | 3.6 3.7 3.8 3.9 |
| amqp | 2.6.1 | 3.6 3.7 3.8 3.9 |
| amqp | 5.0.6 | 3.6 3.7 3.8 3.9 |
| aniso8601 | 7.0.0 | 3.6 3.7 3.8 3.9 |
| aniso8601 | 9.0.1 | 3.6 3.7 3.8 3.9 |
| anndata | 0.7.6 | 3.7 3.8 3.9 |
| ansible | 4.5.0 | 3.6 3.7 3.8 3.9 |
| ansible-core | 2.11.4 | 3.6 3.7 3.8 3.9 |
| ansiwrap | 0.8.4 | 3.6 3.7 3.8 3.9 |
| antlr4-python3-runtime | 4.7.2 | 3.6 3.7 3.8 3.9 |
| antlr4-python3-runtime | 4.8 | 3.6 3.7 3.8 3.9 |
| antlr4-python3-runtime | 4.9.2 | 3.6 3.7 3.8 3.9 |
| anyascii | 0.3.0 | 3.6 3.7 3.8 3.9 |
| anyio | 3.3.0 | 3.7 3.8 3.9 |
| anyio | 3.3.1 | 3.7 3.8 3.9 |
| anyjson | 0.3.3 | 3.6 3.7 3.8 3.9 |
| anytree | 2.8.0 | 3.6 3.7 3.8 3.9 |
| apache-airflow-providers-http | 2.0.1 | 3.6 3.7 3.8 3.9 |
| apispec | 3.3.2 | 3.6 3.7 3.8 3.9 |
| apispec | 5.1.0 | 3.6 3.7 3.8 3.9 |
| appdirs | 1.4.4 | 3.6 3.7 3.8 3.9 |
| appium-python-client | 1.2.0 | 3.6 3.7 3.8 3.9 |
| applicationinsights | 0.11.10 | 3.6 3.7 3.8 3.9 |
| appnope | 0.1.2 | 3.6 3.7 3.8 3.9 |
| apscheduler | 3.6.3 | 3.6 3.7 3.8 3.9 |
| apscheduler | 3.7.0 | 3.6 3.7 3.8 3.9 |
| argcomplete | 1.12.3 | 3.6 3.7 3.8 3.9 |
| argh | 0.26.2 | 3.6 3.7 3.8 3.9 |
| argon2-cffi | 21.1.0 | 3.6 3.7 3.8 3.9 |
| argparse | 1.4.0 | 3.6 3.7 3.8 3.9 |
| args | 0.1.0 | 3.6 3.7 3.8 3.9 |
| ariadne | 0.13.0 | 3.6 3.7 3.8 3.9 |
| arrow | 1.1.1 | 3.6 3.7 3.8 3.9 |
| arviz | 0.11.2 | 3.7 3.8 3.9 |
| asciitree | 0.3.3 | 3.7 3.8 3.9 |
| ase | 3.22.0 | 3.6 3.7 3.8 3.9 |
| asgi-csrf | 0.9 | 3.6 3.7 3.8 3.9 |
| asgiref | 3.4.1 | 3.6 3.7 3.8 3.9 |
| asn1crypto | 1.4.0 | 3.6 3.7 3.8 3.9 |
| astor | 0.8.1 | 3.6 3.7 3.8 3.9 |
| astroid | 2.7.3 | 3.6 3.7 3.8 3.9 |
| astroid | 2.8.0 | 3.6 3.7 3.8 3.9 |
| astropy | 4.1 | 3.6 |
| astropy | 4.3.1 | 3.7 3.8 3.9 |
| astroquery | 0.4.3 | 3.6 3.7 3.8 3.9 |
| astunparse | 1.6.3 | 3.6 3.7 3.8 3.9 |
| async-generator | 1.10 | 3.6 3.7 3.8 3.9 |
| async-lru | 1.0.2 | 3.6 3.7 3.8 3.9 |
| asyncpg | 0.24.0 | 3.6 3.7 3.8 3.9 |
| asyncssh | 2.7.2 | 3.6 3.7 3.8 3.9 |
| asynctest | 0.13.0 | 3.6 3.7 3.8 3.9 |
| async-timeout | 3.0.1 | 3.6 3.7 3.8 3.9 |
| atomicwrites | 1.4.0 | 3.6 3.7 3.8 3.9 |
| attrdict | 2.0.1 | 3.6 3.7 3.8 3.9 |
| attrs | 20.3.0 | 3.6 3.7 3.8 3.9 |
| attrs | 21.2.0 | 3.6 3.7 3.8 3.9 |
| audioread | 2.1.9 | 3.6 3.7 3.8 3.9 |
| authencoding | 4.3 | 3.6 3.7 3.8 3.9 |
| authlib | 0.15.4 | 3.6 3.7 3.8 3.9 |
| autobahn | 21.2.1 | 3.6 |
| autobahn | 21.3.1 | 3.7 3.8 3.9 |
| autoflake | 1.4 | 3.6 3.7 3.8 3.9 |
| autograd | 1.3 | 3.6 3.7 3.8 3.9 |
| automat | 20.2.0 | 3.6 3.7 3.8 3.9 |
| autopage | 0.4.0 | 3.6 3.7 3.8 3.9 |
| autopep8 | 1.5.7 | 3.6 3.7 3.8 3.9 |
| aws-cdk-assets | 1.123.0 | 3.6 3.7 3.8 3.9 |
| aws-cdk-aws-applicationautoscaling | 1.123.0 | 3.6 3.7 3.8 3.9 |
| aws-cdk-aws-autoscaling-common | 1.123.0 | 3.6 3.7 3.8 3.9 |
| aws-cdk-aws-cloudwatch | 1.123.0 | 3.6 3.7 3.8 3.9 |
| aws-cdk-aws-codeguruprofiler | 1.123.0 | 3.6 3.7 3.8 3.9 |
| aws-cdk-aws-codestarnotifications | 1.123.0 | 3.6 3.7 3.8 3.9 |
| aws-cdk-aws-ec2 | 1.123.0 | 3.6 3.7 3.8 3.9 |
| aws-cdk-aws-ecr | 1.123.0 | 3.7 3.8 3.9 |
| aws-cdk-aws-events | 1.123.0 | 3.6 3.7 3.8 3.9 |
| aws-cdk-aws-iam | 1.123.0 | 3.6 3.7 3.8 3.9 |
| aws-cdk-aws-kms | 1.123.0 | 3.6 3.7 3.8 3.9 |
| aws-cdk-aws-logs | 1.123.0 | 3.6 3.7 3.8 3.9 |
| aws-cdk-aws-s3 | 1.123.0 | 3.6 3.7 3.8 3.9 |
| aws-cdk-aws-s3-assets | 1.123.0 | 3.6 3.7 3.8 3.9 |
| aws-cdk-aws-signer | 1.123.0 | 3.6 3.7 3.8 3.9 |
| aws-cdk-aws-sns | 1.123.0 | 3.6 3.7 3.8 3.9 |
| aws-cdk-aws-sqs | 1.123.0 | 3.6 3.7 3.8 3.9 |
| aws-cdk-aws-ssm | 1.123.0 | 3.6 3.7 3.8 3.9 |
| aws-cdk-cloud-assembly-schema | 1.122.0 | 3.6 3.7 3.8 3.9 |
| aws-cdk-cloud-assembly-schema | 1.123.0 | 3.6 3.7 3.8 3.9 |
| aws-cdk-core | 1.123.0 | 3.6 3.7 3.8 3.9 |
| aws-cdk-cx-api | 1.123.0 | 3.6 3.7 3.8 3.9 |
| aws-cdk-region-info | 1.123.0 | 3.6 3.7 3.8 3.9 |
| awscli | 1.20.31 | 3.6 3.7 3.8 3.9 |
| aws-lambda-builders | 1.6.0 | 3.6 3.7 3.8 3.9 |
| aws-okta-processor | 1.7.0 | 3.6 3.7 3.8 3.9 |
| aws-sam-translator | 1.38.0 | 3.6 3.7 3.8 3.9 |
| aws-xray-sdk | 2.8.0 | 3.6 3.7 3.8 3.9 |
| azure-appconfiguration | 1.1.1 | 3.6 3.7 3.8 3.9 |
| azure-batch | 11.0.0 | 3.6 3.7 3.8 3.9 |
| azure-cli | 2.29.0 | 3.6 3.7 3.8 3.9 |
| azure-cli-command-modules-nspkg | 2.0.3 | 3.6 3.7 3.8 3.9 |
| azure-cli-core | 2.29.0 | 3.6 3.7 3.8 3.9 |
| azure-cli-nspkg | 3.0.4 | 3.6 3.7 3.8 3.9 |
| azure-cli-telemetry | 1.0.6 | 3.6 3.7 3.8 3.9 |
| azure-common | 1.1.27 | 3.6 3.7 3.8 3.9 |
| azure-core | 1.18.0 | 3.6 3.7 3.8 3.9 |
| azure-core | 1.19.0 | 3.6 3.7 3.8 3.9 |
| azure-cosmos | 3.2.0 | 3.6 3.7 3.8 3.9 |
| azure-datalake-store | 0.0.52 | 3.6 3.7 3.8 3.9 |
| azure-functions-devops-build | 0.0.22 | 3.6 3.7 3.8 3.9 |
| azure-graphrbac | 0.60.0 | 3.6 3.7 3.8 3.9 |
| azure-graphrbac | 0.61.1 | 3.6 3.7 3.8 |
| azure-identity | 1.6.1 | 3.6 3.7 3.8 3.9 |
| azure-keyvault | 1.1.0 | 3.6 3.7 3.8 3.9 |
| azure-keyvault-administration | 4.0.0b3 | 3.6 3.7 3.8 3.9 |
| azure-keyvault-keys | 4.4.0 | 3.6 3.7 3.8 3.9 |
| azure-loganalytics | 0.1.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-advisor | 9.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-apimanagement | 0.2.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-appconfiguration | 2.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-applicationinsights | 1.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-authorization | 0.61.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-batch | 16.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-batchai | 7.0.0b1 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-billing | 6.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-botservice | 0.3.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-cdn | 11.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-cognitiveservices | 12.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-compute | 23.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-consumption | 2.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-containerinstance | 9.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-containerregistry | 8.1.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-containerservice | 16.1.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-core | 1.2.2 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-core | 1.3.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-cosmosdb | 6.4.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-databoxedge | 1.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-datalake-analytics | 0.2.1 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-datalake-nspkg | 3.0.1 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-datalake-store | 0.5.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-datamigration | 9.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-deploymentmanager | 0.2.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-devtestlabs | 4.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-dns | 8.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-eventgrid | 9.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-eventhub | 9.1.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-extendedlocation | 1.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-hdinsight | 8.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-imagebuilder | 0.4.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-iotcentral | 9.0.0b1 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-iothub | 2.1.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-iothubprovisioningservices | 0.3.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-keyvault | 9.1.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-kusto | 0.3.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-loganalytics | 11.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-managedservices | 1.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-managementgroups | 0.2.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-maps | 2.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-marketplaceordering | 1.1.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-media | 7.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-monitor | 2.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-msi | 0.2.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-netapp | 4.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-network | 19.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-nspkg | 3.0.2 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-policyinsights | 1.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-privatedns | 1.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-rdbms | 9.1.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-recoveryservices | 2.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-recoveryservicesbackup | 0.15.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-redhatopenshift | 1.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-redis | 13.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-relay | 0.1.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-reservations | 0.6.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-resource | 19.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-resource | 20.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-search | 8.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-security | 2.0.0b1 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-servicebus | 6.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-servicefabric | 1.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-servicefabricmanagedclusters | 1.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-signalr | 1.0.0b2 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-sql | 3.0.1 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-sqlvirtualmachine | 1.0.0b1 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-storage | 19.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-synapse | 2.0.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-trafficmanager | 0.51.0 | 3.6 3.7 3.8 3.9 |
| azure-mgmt-web | 4.0.0 | 3.6 3.7 3.8 3.9 |
| azure-multiapi-storage | 0.6.2 | 3.6 3.7 3.8 3.9 |
| azure-nspkg | 3.0.2 | 3.6 3.7 3.8 3.9 |
| azure-storage-blob | 12.8.1 | 3.6 3.7 3.8 3.9 |
| azure-storage-common | 1.4.2 | 3.6 3.7 3.8 3.9 |
| azure-synapse-accesscontrol | 0.5.0 | 3.6 3.7 3.8 3.9 |
| azure-synapse-artifacts | 0.8.0 | 3.6 3.7 3.8 3.9 |
| azure-synapse-managedprivateendpoints | 0.3.0 | 3.6 3.7 3.8 3.9 |
| azure-synapse-spark | 0.2.0 | 3.6 3.7 3.8 3.9 |
| babel | 2.9.1 | 3.6 3.7 3.8 3.9 |
| backcall | 0.2.0 | 3.6 3.7 3.8 3.9 |
| backoff | 1.11.1 | 3.6 3.7 3.8 3.9 |
| backoff | 1.8.0 | 3.6 3.7 3.8 3.9 |
| backports-csv | 1.0.7 | 3.6 3.7 3.8 3.9 |
| backports-entry-points-selectable | 1.1.0 | 3.6 3.7 3.8 3.9 |
| backports-functools-lru-cache | 1.6.4 | 3.6 3.7 3.8 3.9 |
| backports-zoneinfo | 0.2.1 | 3.6 3.7 3.8 3.9 |
| base58 | 2.1.0 | 3.6 3.7 3.8 3.9 |
| bcrypt | 3.2.0 | 3.6 3.7 3.8 3.9 |
| beautifulsoup4 | 4.10.0 | 3.6 3.7 3.8 3.9 |
| beautifulsoup4 | 4.9.3 | 3.6 3.7 3.8 3.9 |
| behave | 1.2.6 | 3.6 3.7 3.8 3.9 |
| bibtexparser | 1.2.0 | 3.6 3.7 3.8 3.9 |
| bidict | 0.21.3 | 3.6 3.7 3.8 3.9 |
| billiard | 3.6.4.0 | 3.6 3.7 3.8 3.9 |
| binaryornot | 0.4.4 | 3.6 3.7 3.8 3.9 |
| biopython | 1.79 | 3.6 3.7 3.8 3.9 |
| bitarray | 1.2.2 | 3.6 3.7 3.8 3.9 |
| bitstring | 3.1.9 | 3.6 3.7 3.8 3.9 |
| black | 21.8b0 | 3.7 3.8 3.9 |
| bleach | 4.1.0 | 3.6 3.7 3.8 3.9 |
| blessed | 1.18.1 | 3.6 3.7 3.8 3.9 |
| blessings | 1.7 | 3.6 3.7 3.8 3.9 |
| blinker | 1.4 | 3.6 3.7 3.8 3.9 |
| blis | 0.7.4 | 3.6 3.7 3.8 3.9 |
| bluemix-service-discovery | 0.0.1 | 3.6 3.7 3.8 3.9 |
| bokeh | 2.3.3 | 3.6 |
| bokeh | 2.4.0 | 3.7 3.8 3.9 |
| boltons | 21.0.0 | 3.6 3.7 3.8 3.9 |
| bootstrap-admin | 0.4.4 | 3.6 3.7 3.8 3.9 |
| borg-localrole | 3.1.8 | 3.6 3.7 3.8 3.9 |
| boto | 2.49.0 | 3.6 3.7 3.8 3.9 |
| boto3 | 1.12.32 | 3.6 3.7 3.8 3.9 |
| boto3 | 1.17.106 | 3.6 3.7 3.8 3.9 |
| boto3 | 1.18.31 | 3.6 3.7 3.8 3.9 |
| boto3 | 1.18.32 | 3.6 3.7 3.8 3.9 |
| boto3 | 1.18.39 | 3.6 3.7 3.8 3.9 |
| boto3 | 1.18.44 | 3.6 3.7 3.8 3.9 |
| boto3-type-annotations | 0.3.1 | 3.6 3.7 3.8 3.9 |
| botocore | 1.15.32 | 3.6 3.7 3.8 3.9 |
| botocore | 1.15.49 | 3.6 3.7 3.8 3.9 |
| botocore | 1.20.106 | 3.6 3.7 3.8 3.9 |
| botocore | 1.20.112 | 3.6 3.7 3.8 3.9 |
| botocore | 1.21.31 | 3.6 3.7 3.8 3.9 |
| botocore | 1.21.32 | 3.6 |
| botocore | 1.21.36 | 3.6 3.7 3.8 3.9 |
| botocore | 1.21.39 | 3.6 3.7 3.8 3.9 |
| botocore | 1.21.44 | 3.6 3.7 3.8 3.9 |
| bottle | 0.12.19 | 3.6 3.7 3.8 3.9 |
| branca | 0.4.2 | 3.6 3.7 3.8 3.9 |
| brotli | 1.0.9 | 3.6 3.7 3.8 3.9 |
| brotlicffi | 1.0.9.2 | 3.6 3.7 3.8 3.9 |
| bs4 | 0.0.1 | 3.6 3.7 3.8 3.9 |
| bson | 0.5.10 | 3.6 3.7 3.8 3.9 |
| btrees | 4.9.2 | 3.6 3.7 3.8 3.9 |
| bugsnag | 4.1.0 | 3.6 3.7 3.8 3.9 |
| build | 0.6.1 | 3.6 3.7 3.8 3.9 |
| build | 0.7.0 | 3.6 3.7 3.8 3.9 |
| bump2version | 1.0.1 | 3.6 3.7 3.8 3.9 |
| bumpversion | 0.6.0 | 3.6 3.7 3.8 3.9 |
| cachecontrol | 0.12.6 | 3.6 3.7 3.8 3.9 |
| cached-property | 1.5.2 | 3.6 3.7 3.8 3.9 |
| cachetools | 4.2.2 | 3.6 3.7 3.8 3.9 |
| cachey | 0.2.1 | 3.7 3.8 3.9 |
| cachy | 0.3.0 | 3.6 3.7 3.8 3.9 |
| calmjs-parse | 1.2.5 | 3.6 3.7 3.8 3.9 |
| capacity | 1.3.14 | 3.6 3.7 3.8 3.9 |
| cassandra-driver | 3.25.0 | 3.6 3.7 3.8 3.9 |
| catalogue | 2.0.6 | 3.6 3.7 3.8 3.9 |
| catboost | 0.26.1 | 3.6 3.7 3.8 3.9 |
| category-encoders | 2.2.2 | 3.6 3.7 3.8 3.9 |
| catkin-pkg | 0.4.23 | 3.6 3.7 3.8 3.9 |
| cattrs | 1.0.0 | 3.6 3.7 3.8 |
| cattrs | 1.1.0 | 3.7 3.8 3.9 |
| cattrs | 1.8.0 | 3.7 3.8 3.9 |
| cbor2 | 5.4.1 | 3.6 3.7 3.8 3.9 |
| cchardet | 2.1.7 | 3.6 3.7 3.8 3.9 |
| cdiff | 1.0 | 3.6 3.7 3.8 3.9 |
| celery | 5.1.2 | 3.6 3.7 3.8 3.9 |
| certbot | 1.19.0 | 3.6 3.7 3.8 3.9 |
| certifi | 2021.10.8 | 3.6 3.7 3.8 3.9 |
| certifi | 2021.5.30 | 3.6 3.7 3.8 3.9 |
| certipy | 0.1.3 | 3.6 3.7 3.8 3.9 |
| cffi | 1.14.6 | 3.6 3.7 3.8 3.9 |
| cffi | 1.15.0 | 3.6 3.7 3.8 3.9 |
| cfgv | 3.3.1 | 3.7 3.8 3.9 |
| cfn-flip | 1.2.3 | 3.6 3.7 3.8 3.9 |
| cfn-lint | 0.53.0 | 3.6 3.7 3.8 3.9 |
| cftime | 1.5.0 | 3.6 3.7 3.8 3.9 |
| chameleon | 3.9.1 | 3.6 3.7 3.8 3.9 |
| channels | 3.0.4 | 3.6 3.7 3.8 3.9 |
| chardet | 3.0.4 | 3.6 3.7 3.8 3.9 |
| chardet | 4.0.0 | 3.6 3.7 3.8 3.9 |
| charset-normalizer | 2.0.4 | 3.6 3.7 3.8 3.9 |
| charset-normalizer | 2.0.6 | 3.6 3.7 3.8 3.9 |
| charset-normalizer | 2.0.7 | 3.6 3.7 3.8 3.9 |
| check-manifest | 0.46 | 3.6 3.7 3.8 3.9 |
| cheroot | 8.5.2 | 3.6 3.7 3.8 3.9 |
| cherrypy | 18.6.1 | 3.6 3.7 3.8 3.9 |
| circuits | 3.2.1 | 3.6 3.7 3.8 3.9 |
| ciso8601 | 2.2.0 | 3.6 3.8 3.9 |
| clang | 5.0 | 3.6 3.7 3.8 3.9 |
| cleo | 0.6.8 | 3.6 3.7 3.8 3.9 |
| cleo | 0.8.1 | 3.6 3.7 3.8 3.9 |
| cliar | 1.3.4 | 3.6 3.7 3.8 3.9 |
| click | 7.1.2 | 3.6 3.7 3.8 3.9 |
| click | 8.0.1 | 3.6 3.7 3.8 3.9 |
| clickclick | 20.10.2 | 3.6 3.7 3.8 3.9 |
| click-completion | 0.5.2 | 3.6 3.7 3.8 3.9 |
| click-default-group | 1.2.2 | 3.6 3.7 3.8 3.9 |
| click-didyoumean | 0.0.3 | 3.6 3.7 3.8 3.9 |
| click-help-colors | 0.9.1 | 3.6 3.7 3.8 3.9 |
| click-log | 0.3.2 | 3.6 3.7 3.8 3.9 |
| click-plugins | 1.1.1 | 3.6 3.7 3.8 3.9 |
| click-repl | 0.2.0 | 3.6 3.7 3.8 3.9 |
| click-spinner | 0.1.10 | 3.6 3.7 3.8 3.9 |
| cliff | 3.9.0 | 3.6 3.7 3.8 3.9 |
| cligj | 0.7.2 | 3.6 3.7 3.8 3.9 |
| clikit | 0.6.2 | 3.6 3.7 3.8 3.9 |
| clint | 0.5.1 | 3.6 3.7 3.8 3.9 |
| cloudmersive-virus-api-client | 3.0.5 | 3.6 3.7 3.8 3.9 |
| cloudpickle | 1.6.0 | 3.6 3.7 3.8 3.9 |
| cloudpickle | 2.0.0 | 3.6 3.7 3.8 3.9 |
| cmaes | 0.8.2 | 3.6 3.7 3.8 3.9 |
| cmake | 3.21.2 | 3.6 3.7 3.8 3.9 |
| cmd2 | 2.2.0 | 3.6 3.7 3.8 3.9 |
| codecov | 2.1.12 | 3.6 3.7 3.8 3.9 |
| collective-monkeypatcher | 1.2.1 | 3.6 3.7 3.8 3.9 |
| colorama | 0.4.3 | 3.6 3.7 3.8 3.9 |
| colorama | 0.4.4 | 3.6 3.7 3.8 3.9 |
| colorcet | 2.0.6 | 3.6 |
| colorclass | 2.2.0 | 3.6 3.7 3.8 3.9 |
| colored | 1.4.2 | 3.6 3.7 3.8 3.9 |
| colorlog | 6.4.1 | 3.6 3.7 3.8 3.9 |
| commonmark | 0.9.1 | 3.6 3.7 3.8 3.9 |
| configargparse | 1.5.2 | 3.6 3.7 3.8 3.9 |
| configobj | 5.0.6 | 3.6 3.7 3.8 3.9 |
| configparser | 5.0.2 | 3.6 3.7 3.8 3.9 |
| confluent-kafka | 1.7.0 | 3.6 3.7 3.8 3.9 |
| confuse | 1.5.0 | 3.6 3.7 3.8 3.9 |
| connection-pool | 0.0.3 | 3.6 |
| constantly | 15.1.0 | 3.6 3.7 3.8 3.9 |
| construct | 2.10.67 | 3.6 3.7 3.8 3.9 |
| constructs | 10.0.5 | 3.6 3.7 3.8 3.9 |
| constructs | 3.3.147 | 3.6 3.7 3.8 3.9 |
| contextlib2 | 21.6.0 | 3.6 3.7 3.8 3.9 |
| contextvars | 2.4 | 3.6 |
| convertdate | 2.3.2 | 3.6 3.7 3.8 3.9 |
| cookiecutter | 1.7.3 | 3.6 3.7 3.8 3.9 |
| copyright | 1.0.1.0 | 3.6 3.7 3.8 3.9 |
| coreschema | 0.0.4 | 3.6 3.7 3.8 3.9 |
| corner | 2.2.1 | 3.6 3.7 3.8 3.9 |
| countrycode | 0.2 | 3.6 3.7 3.8 3.9 |
| coverage | 5.5 | 3.6 3.7 3.8 3.9 |
| coverage-badge | 1.0.1 | 3.6 3.7 3.8 3.9 |
| coveralls | 3.2.0 | 3.6 3.7 3.8 3.9 |
| cramjam | 2.4.0 | 3.7 3.8 3.9 |
| crashtest | 0.3.1 | 3.6 3.7 3.8 3.9 |
| crayons | 0.4.0 | 3.6 3.7 3.8 3.9 |
| croniter | 1.0.15 | 3.6 3.7 3.8 3.9 |
| cryptography | 3.3.2 | 3.6 3.7 3.8 3.9 |
| cryptography | 3.4.8 | 3.6 3.7 3.8 3.9 |
| cryptography | 35.0.0 | 3.6 3.7 3.8 3.9 |
| cssmin | 0.2.0 | 3.6 3.7 3.8 3.9 |
| cssselect | 1.1.0 | 3.6 3.7 3.8 3.9 |
| cssselect2 | 0.4.1 | 3.6 3.7 3.8 3.9 |
| cssutils | 2.3.0 | 3.6 3.7 3.8 3.9 |
| cvxopt | 1.2.6 | 3.6 3.7 3.8 3.9 |
| cx-oracle | 8.2.1 | 3.6 3.7 3.8 3.9 |
| cycler | 0.10.0 | 3.6 3.7 3.8 3.9 |
| cymem | 2.0.5 | 3.6 3.7 3.8 3.9 |
| cython | 0.29.24 | 3.6 3.7 3.8 3.9 |
| cytoolz | 0.11.0 | 3.6 3.7 3.8 3.9 |
| dacite | 1.6.0 | 3.6 3.7 3.8 3.9 |
| daphne | 3.0.2 | 3.6 3.7 3.8 3.9 |
| dask | 2021.9.0 | 3.7 3.8 3.9 |
| databricks-cli | 0.15.0 | 3.6 3.7 3.8 3.9 |
| dataclasses | 0.6 | 3.7 3.8 3.9 |
| dataclasses | 0.8 | 3.6 |
| dataclasses-json | 0.5.5 | 3.6 3.7 3.8 3.9 |
| datadog | 0.42.0 | 3.6 3.7 3.8 3.9 |
| datasets | 1.12.1 | 3.6 3.7 3.8 3.9 |
| datasette | 0.58.1 | 3.6 3.7 3.8 3.9 |
| dateparser | 1.0.0 | 3.6 3.7 3.8 3.9 |
| datetime | 4.3 | 3.6 3.7 3.8 3.9 |
| dateutils | 0.6.12 | 3.6 3.7 3.8 3.9 |
| datrie | 0.8.2 | 3.6 |
| dbutils | 2.0.2 | 3.6 |
| ddt | 1.4.2 | 3.6 3.7 3.8 3.9 |
| debtcollector | 2.3.0 | 3.6 3.7 3.8 3.9 |
| debugpy | 1.4.3 | 3.7 3.8 3.9 |
| decorator | 4.4.2 | 3.6 3.7 3.8 3.9 |
| decorator | 5.0.9 | 3.6 3.7 3.8 3.9 |
| decorator | 5.1.0 | 3.6 3.7 3.8 3.9 |
| deepdiff | 5.5.0 | 3.6 3.7 3.8 3.9 |
| deepmerge | 0.3.0 | 3.6 3.7 3.8 3.9 |
| defusedxml | 0.7.1 | 3.6 3.7 3.8 3.9 |
| delighted | 4.1.0 | 3.6 3.7 3.8 3.9 |
| demands | 5.0.0 | 3.6 3.7 3.8 3.9 |
| demes | 0.1.2 | 3.7 3.8 3.9 |
| deprecated | 1.2.12 | 3.6 3.7 3.8 3.9 |
| deprecated | 1.2.13 | 3.6 3.7 3.8 3.9 |
| deprecation | 2.1.0 | 3.6 3.7 3.8 3.9 |
| descartes | 1.1.0 | 3.7 3.8 3.9 |
| diazo | 1.4.1 | 3.6 3.7 3.8 3.9 |
| dictdiffer | 0.9.0 | 3.6 3.7 3.8 3.9 |
| dicttoxml | 1.7.4 | 3.6 3.7 3.8 3.9 |
| dill | 0.3.4 | 3.6 3.7 3.8 3.9 |
| discord | 1.7.3 | 3.6 3.7 3.8 3.9 |
| discord-py | 1.7.3 | 3.6 3.7 3.8 3.9 |
| discover | 0.4.0 | 3.6 3.7 3.8 3.9 |
| diskcache | 5.2.1 | 3.6 3.7 3.8 3.9 |
| distlib | 0.3.2 | 3.6 3.7 3.8 3.9 |
| distributed | 2021.9.0 | 3.7 3.8 3.9 |
| distro | 1.6.0 | 3.6 3.7 3.8 3.9 |
| django | 3.2.7 | 3.6 3.7 3.8 3.9 |
| django-allauth | 0.45.0 | 3.6 3.7 3.8 3.9 |
| django-anymail | 8.4 | 3.6 3.7 3.8 3.9 |
| django-appconf | 1.0.4 | 3.6 3.7 3.8 3.9 |
| django-cacheops | 6.0 | 3.6 3.7 3.8 3.9 |
| django-cache-url | 3.2.3 | 3.6 3.7 3.8 3.9 |
| django-classy-tags | 2.0.0 | 3.6 3.7 3.8 3.9 |
| django-cleanup | 5.2.0 | 3.6 3.7 3.8 3.9 |
| djangocms-admin-style | 2.0.2 | 3.6 3.7 3.8 3.9 |
| django-cors-headers | 3.8.0 | 3.6 3.7 3.8 3.9 |
| django-crispy-forms | 1.12.0 | 3.6 3.7 3.8 3.9 |
| django-debug-toolbar | 3.2.2 | 3.6 3.7 3.8 3.9 |
| django-environ | 0.7.0 | 3.6 3.7 3.8 3.9 |
| django-extensions | 3.1.3 | 3.6 3.7 3.8 3.9 |
| django-filer | 2.0.2 | 3.6 3.7 3.8 3.9 |
| django-filter | 2.4.0 | 3.6 3.7 3.8 3.9 |
| django-js-asset | 1.2.2 | 3.6 3.7 3.8 3.9 |
| django-modelcluster | 5.1 | 3.6 3.7 3.8 3.9 |
| django-mptt | 0.13.3 | 3.6 3.7 3.8 3.9 |
| django-mptt | 0.13.4 | 3.6 3.7 3.8 3.9 |
| django-polymorphic | 3.0.0 | 3.6 3.7 3.8 3.9 |
| django-redis | 5.0.0 | 3.6 3.7 3.8 3.9 |
| djangorestframework | 3.12.4 | 3.6 3.7 3.8 3.9 |
| django-rest-passwordreset | 1.2.0 | 3.6 3.7 3.8 3.9 |
| django-taggit | 1.5.1 | 3.6 3.7 3.8 3.9 |
| django-treebeard | 4.5.1 | 3.6 3.7 3.8 3.9 |
| dj-database-url | 0.5.0 | 3.6 3.7 3.8 3.9 |
| dlx | 1.0.4 | 3.6 3.7 3.8 3.9 |
| dm-tree | 0.1.6 | 3.6 3.7 3.8 3.9 |
| dnslib | 0.9.16 | 3.6 3.7 3.8 3.9 |
| dnspython | 1.16.0 | 3.6 3.7 3.8 3.9 |
| dnspython | 2.1.0 | 3.6 3.7 3.8 3.9 |
| docker | 5.0.0 | 3.6 3.7 3.8 3.9 |
| docker | 5.0.2 | 3.6 3.7 3.8 3.9 |
| docker-compose | 1.29.2 | 3.6 3.7 3.8 3.9 |
| dockerpty | 0.4.1 | 3.6 3.7 3.8 3.9 |
| docker-py | 1.10.6 | 3.6 3.7 3.8 3.9 |
| docker-pycreds | 0.4.0 | 3.6 3.7 3.8 3.9 |
| docker-services-cli | 0.3.1 | 3.6 3.7 3.8 3.9 |
| docopt | 0.6.2 | 3.6 3.7 3.8 3.9 |
| docplex | 2.22.213 | 3.6 3.7 3.8 3.9 |
| documenttemplate | 4.0 | 3.6 3.7 3.8 3.9 |
| docutils | 0.15.2 | 3.6 3.7 3.8 3.9 |
| docutils | 0.16 | 3.6 3.7 3.8 3.9 |
| docutils | 0.17.1 | 3.6 3.7 3.8 3.9 |
| docxcompose | 1.3.3 | 3.6 3.7 3.8 3.9 |
| docxtpl | 0.12.0 | 3.6 3.7 3.8 3.9 |
| dodgy | 0.2.1 | 3.7 3.8 3.9 |
| dogpile-cache | 1.1.4 | 3.6 3.7 3.8 3.9 |
| dominate | 2.6.0 | 3.6 3.7 3.8 3.9 |
| dotmap | 1.3.24 | 3.6 3.7 3.8 3.9 |
| dparse | 0.5.1 | 3.6 3.7 3.8 3.9 |
| dpath | 2.0.2 | 3.6 3.7 3.8 3.9 |
| draftjs-exporter | 2.1.7 | 3.6 3.7 3.8 3.9 |
| dropbox | 11.19.0 | 3.6 3.7 3.8 3.9 |
| dtw | 1.4.0 | 3.6 3.7 3.8 3.9 |
| duckduckpy | 0.2 | 3.6 3.7 3.8 3.9 |
| dulwich | 0.20.25 | 3.6 3.7 3.8 3.9 |
| dynaconf | 3.1.5 | 3.6 3.7 3.8 3.9 |
| easyprocess | 0.3 | 3.6 3.7 3.8 3.9 |
| easy-thumbnails | 2.7.1 | 3.6 3.7 3.8 3.9 |
| ecdsa | 0.17.0 | 3.6 3.7 3.8 3.9 |
| einops | 0.3.2 | 3.6 3.7 3.8 3.9 |
| elasticsearch | 7.14.1 | 3.6 3.7 3.8 3.9 |
| elasticsearch-dsl | 7.4.0 | 3.6 3.7 3.8 3.9 |
| email-validator | 1.1.3 | 3.6 3.7 3.8 3.9 |
| emcee | 3.1.1 | 3.6 3.7 3.8 3.9 |
| emoji | 1.4.2 | 3.6 3.7 3.8 3.9 |
| empyrical | 0.5.5 | 3.6 3.7 3.8 3.9 |
| entrypoints | 0.3 | 3.6 3.7 3.8 3.9 |
| enum34 | 1.1.10 | 3.6 3.7 3.8 3.9 |
| enum-compat | 0.0.3 | 3.6 3.7 3.8 3.9 |
| environs | 9.3.3 | 3.6 3.7 3.8 3.9 |
| eth-hash | 0.3.2 | 3.6 3.7 3.8 3.9 |
| eth-typing | 2.2.2 | 3.6 3.7 3.8 3.9 |
| et-xmlfile | 1.1.0 | 3.6 3.7 3.8 3.9 |
| exception | 0.1.0 | 3.6 3.7 3.8 3.9 |
| execnet | 1.9.0 | 3.6 3.7 3.8 3.9 |
| exponent-server-sdk | 2.0.0 | 3.6 3.7 3.8 3.9 |
| extensionclass | 4.5.1 | 3.6 3.7 3.8 3.9 |
| extras | 1.0.0 | 3.6 3.7 3.8 3.9 |
| fabric | 2.6.0 | 3.6 3.7 3.8 3.9 |
| faker | 8.12.1 | 3.6 3.7 3.8 3.9 |
| faker | 8.13.2 | 3.6 3.7 3.8 3.9 |
| fake-useragent | 0.1.11 | 3.6 3.7 3.8 3.9 |
| falcon | 3.0.1 | 3.6 3.7 3.8 3.9 |
| fastai | 2.5.2 | 3.7 3.8 3.9 |
| fastapi | 0.68.1 | 3.6 3.7 3.8 3.9 |
| fastavro | 1.4.4 | 3.6 3.7 3.8 3.9 |
| fastcore | 1.3.26 | 3.6 3.7 3.8 3.9 |
| fastdownload | 0.0.5 | 3.7 3.8 3.9 |
| fastdtw | 0.3.4 | 3.6 3.7 3.8 3.9 |
| fasteners | 0.16.3 | 3.6 3.7 3.8 3.9 |
| fastjsonschema | 2.15.1 | 3.6 3.7 3.8 3.9 |
| fastprogress | 1.0.0 | 3.7 3.8 3.9 |
| fb | 0.4.0 | 3.6 3.7 3.8 3.9 |
| fdk | 0.1.36 | 3.6 3.7 3.8 3.9 |
| feedgenerator | 1.9.2 | 3.6 3.7 3.8 3.9 |
| feedparser | 6.0.8 | 3.6 3.7 3.8 3.9 |
| ffmpeg-python | 0.2.0 | 3.6 3.7 3.8 3.9 |
| filelock | 3.0.12 | 3.6 3.7 3.8 3.9 |
| filetype | 1.0.7 | 3.6 3.7 3.8 3.9 |
| fire | 0.4.0 | 3.6 3.7 3.8 3.9 |
| five-customerize | 2.0.1 | 3.6 3.7 3.8 3.9 |
| five-intid | 1.2.6 | 3.6 3.7 3.8 3.9 |
| five-localsitemanager | 3.2.2 | 3.6 3.7 3.8 3.9 |
| flake8 | 2.3.0 | 3.7 3.8 3.9 |
| flake8 | 3.9.2 | 3.6 3.7 3.8 3.9 |
| flake8-bugbear | 21.9.1 | 3.6 3.7 3.8 3.9 |
| flake8-comprehensions | 3.6.1 | 3.6 3.7 3.8 3.9 |
| flake8-docstrings | 1.6.0 | 3.6 3.7 3.8 3.9 |
| flake8-import-order | 0.18.1 | 3.6 3.7 3.8 3.9 |
| flake8-isort | 4.0.0 | 3.6 3.7 3.8 3.9 |
| flake8-polyfill | 1.0.2 | 3.6 3.7 3.8 3.9 |
| flake8-print | 4.0.0 | 3.6 3.7 3.8 3.9 |
| flake8-quotes | 3.3.0 | 3.6 3.7 3.8 3.9 |
| flask | 1.1.2 | 3.6 3.7 3.8 3.9 |
| flask | 1.1.4 | 3.6 3.7 3.8 3.9 |
| flask | 2.0.1 | 3.6 3.7 3.8 3.9 |
| flask-admin | 1.5.8 | 3.6 3.7 3.8 3.9 |
| flask-appbuilder | 3.3.2 | 3.6 3.7 3.8 3.9 |
| flask-babel | 1.0.0 | 3.6 3.7 3.8 3.9 |
| flask-babelex | 0.9.4 | 3.6 3.7 3.8 3.9 |
| flask-caching | 1.10.1 | 3.6 3.7 3.8 3.9 |
| flask-compress | 1.10.1 | 3.6 3.7 3.8 3.9 |
| flask-cors | 3.0.10 | 3.6 3.7 3.8 3.9 |
| flask-debugtoolbar | 0.11.0 | 3.6 3.7 3.8 3.9 |
| flask-httpauth | 4.4.0 | 3.6 3.7 3.8 3.9 |
| flask-jwt-extended | 3.25.1 | 3.6 3.7 3.8 3.9 |
| flask-login | 0.4.1 | 3.6 3.7 3.8 3.9 |
| flask-login | 0.5.0 | 3.6 3.7 3.8 3.9 |
| flask-mail | 0.9.1 | 3.6 3.7 3.8 3.9 |
| flask-marshmallow | 0.14.0 | 3.6 3.7 3.8 3.9 |
| flask-moment | 1.0.2 | 3.6 3.7 3.8 3.9 |
| flask-openid | 1.3.0 | 3.6 3.7 3.8 3.9 |
| flask-pytest | 0.0.5 | 3.6 3.7 3.8 3.9 |
| flask-rbac | 0.5.0 | 3.6 3.7 3.8 3.9 |
| flask-restful | 0.3.9 | 3.6 3.7 3.8 3.9 |
| flask-reverse-proxy | 0.2.0.2 | 3.6 3.7 3.8 3.9 |
| flask-shell-ipython | 0.4.1 | 3.6 3.7 3.8 3.9 |
| flask-socketio | 5.1.1 | 3.6 3.7 3.8 3.9 |
| flask-sqlalchemy | 2.5.1 | 3.6 3.7 3.8 3.9 |
| flask-weasyprint | 0.6 | 3.6 3.7 3.8 3.9 |
| flask-wtf | 0.14.3 | 3.6 3.7 3.8 3.9 |
| flask-wtf | 0.15.1 | 3.6 3.7 3.8 3.9 |
| flatbuffers | 1.12 | 3.6 3.7 3.8 3.9 |
| flatbuffers | 2.0 | 3.6 3.7 3.8 3.9 |
| folium | 0.12.1 | 3.6 3.7 3.8 3.9 |
| fonttools | 4.26.2 | 3.6 3.7 3.8 3.9 |
| formal | 0.6.3 | 3.6 3.7 3.8 3.9 |
| fpdf | 1.7.2 | 3.6 3.7 3.8 3.9 |
| freetype-py | 2.2.0 | 3.7 3.8 3.9 |
| freezegun | 1.1.0 | 3.6 3.7 3.8 3.9 |
| frozendict | 2.0.6 | 3.6 3.7 3.8 3.9 |
| fsspec | 2021.8.1 | 3.6 3.7 3.8 3.9 |
| ftfy | 6.0.3 | 3.6 3.7 3.8 3.9 |
| funcsigs | 1.0.2 | 3.6 3.7 3.8 3.9 |
| funcy | 1.16 | 3.6 3.7 3.8 3.9 |
| furl | 2.1.2 | 3.6 3.7 3.8 3.9 |
| furo | 2021.9.8 | 3.6 3.7 3.8 3.9 |
| future | 0.18.2 | 3.6 3.7 3.8 3.9 |
| future-fstrings | 1.2.0 | 3.6 3.7 3.8 3.9 |
| futurist | 2.4.0 | 3.6 3.7 3.8 3.9 |
| fuzzywuzzy | 0.18.0 | 3.6 3.7 3.8 3.9 |
| gast | 0.4.0 | 3.6 3.7 3.8 3.9 |
| gast | 0.5.2 | 3.6 3.7 3.8 3.9 |
| gcsfs | 2021.8.1 | 3.6 3.7 3.8 3.9 |
| genshi | 0.7.5 | 3.6 3.7 3.8 3.9 |
| gensim | 4.1.0 | 3.6 3.7 3.8 3.9 |
| geoalchemy2 | 0.9.4 | 3.6 3.7 3.8 3.9 |
| geocoder | 1.38.1 | 3.8 3.9 |
| geographiclib | 1.52 | 3.6 3.7 3.8 3.9 |
| geoip2 | 4.2.0 | 3.6 3.7 3.8 3.9 |
| geojson | 2.5.0 | 3.6 3.7 3.8 3.9 |
| geomet | 0.2.1.post1 | 3.6 3.7 3.8 3.9 |
| getdist | 1.3.2 | 3.6 3.7 3.8 3.9 |
| gevent | 21.8.0 | 3.6 3.7 3.8 3.9 |
| gg | 0.0.21 | 3.6 3.7 3.8 3.9 |
| ghp-import | 2.0.1 | 3.6 3.7 3.8 3.9 |
| gitdb | 4.0.7 | 3.6 3.7 3.8 3.9 |
| gitdb2 | 4.0.2 | 3.6 3.7 3.8 3.9 |
| github3-py | 2.0.0 | 3.6 3.7 3.8 3.9 |
| gitpython | 3.1.18 | 3.6 3.7 3.8 3.9 |
| gitpython | 3.1.20 | 3.6 3.7 3.8 3.9 |
| gitpython | 3.1.23 | 3.7 3.8 3.9 |
| gitpython | 3.1.24 | 3.7 3.8 3.9 |
| glob2 | 0.7 | 3.6 3.7 3.8 3.9 |
| google | 3.0.0 | 3.6 3.7 3.8 3.9 |
| google-api-core | 1.31.2 | 3.6 3.7 3.8 3.9 |
| google-api-core | 2.0.1 | 3.6 3.7 3.8 3.9 |
| google-api-python-client | 1.12.8 | 3.6 3.7 3.8 3.9 |
| google-api-python-client | 2.20.0 | 3.6 3.7 3.8 3.9 |
| googleapis-common-protos | 1.53.0 | 3.6 3.7 3.8 3.9 |
| google-auth | 1.35.0 | 3.6 3.7 3.8 3.9 |
| google-auth | 2.0.2 | 3.6 3.7 3.8 3.9 |
| google-auth | 2.1.0 | 3.6 3.7 3.8 3.9 |
| google-auth-httplib2 | 0.1.0 | 3.6 3.7 3.8 3.9 |
| google-auth-oauthlib | 0.4.6 | 3.6 3.7 3.8 3.9 |
| google-cloud | 0.34.0 | 3.6 3.7 3.8 3.9 |
| google-cloud-appengine-logging | 0.1.4 | 3.6 3.7 3.8 3.9 |
| google-cloud-bigquery | 2.26.0 | 3.6 3.7 3.8 3.9 |
| google-cloud-core | 2.0.0 | 3.6 3.7 3.8 3.9 |
| google-cloud-datastore | 2.1.6 | 3.6 3.7 3.8 3.9 |
| google-cloud-firestore | 2.3.2 | 3.6 3.7 3.8 3.9 |
| google-cloud-pubsub | 2.8.0 | 3.6 3.7 3.8 3.9 |
| google-crc32c | 1.1.2 | 3.6 3.7 3.8 3.9 |
| google-pasta | 0.2.0 | 3.6 3.7 3.8 3.9 |
| google-resumable-media | 2.0.2 | 3.6 3.7 3.8 3.9 |
| gql | 2.0.0 | 3.6 3.7 3.8 3.9 |
| grapheme | 0.6.0 | 3.6 3.7 3.8 3.9 |
| graphene | 2.1.9 | 3.6 3.7 3.8 3.9 |
| graphql-core | 2.3.2 | 3.6 3.7 3.8 3.9 |
| graphql-core | 3.1.6 | 3.6 3.7 3.8 3.9 |
| graphql-relay | 2.0.1 | 3.6 3.7 3.8 3.9 |
| graphviz | 0.17 | 3.6 3.7 3.8 3.9 |
| greeking | 2.2.0 | 3.6 3.7 3.8 3.9 |
| greenlet | 1.1.1 | 3.6 3.7 3.8 3.9 |
| grequests | 0.6.0 | 3.6 3.7 3.8 3.9 |
| grpc-google-iam-v1 | 0.12.3 | 3.6 3.7 3.8 3.9 |
| grpcio | 1.39.0 | 3.6 3.7 3.8 3.9 |
| grpcio | 1.40.0 | 3.6 3.7 3.8 3.9 |
| grpcio-health-checking | 1.40.0 | 3.6 3.7 3.8 3.9 |
| grpcio-tools | 1.40.0 | 3.6 3.7 3.8 3.9 |
| gspread | 4.0.1 | 3.6 3.7 3.8 3.9 |
| gtts | 2.2.3 | 3.6 3.7 3.8 3.9 |
| gunicorn | 20.1.0 | 3.6 3.7 3.8 3.9 |
| gym | 0.19.0 | 3.6 3.7 3.8 3.9 |
| h11 | 0.12.0 | 3.6 3.7 3.8 3.9 |
| h11 | 0.9.0 | 3.6 3.7 3.8 3.9 |
| h2 | 3.2.0 | 3.6 3.7 3.8 3.9 |
| h5py | 3.1.0 | 3.6 3.7 3.8 3.9 |
| h5py | 3.2.1 | 3.7 3.8 3.9 |
| h5py | 3.4.0 | 3.7 3.8 3.9 |
| halo | 0.0.31 | 3.6 3.7 3.8 3.9 |
| hdfs3 | 0.3.1 | 3.6 3.7 3.8 3.9 |
| healpy | 1.15.0 | 3.7 3.8 3.9 |
| heapdict | 1.0.1 | 3.7 3.8 3.9 |
| hexbytes | 0.2.2 | 3.6 3.7 3.8 3.9 |
| hidapi | 0.10.1 | 3.6 3.7 3.8 3.9 |
| hiredis | 2.0.0 | 3.6 3.7 3.8 3.9 |
| hpack | 3.0.0 | 3.6 3.7 3.8 3.9 |
| hsluv | 5.0.2 | 3.7 3.8 3.9 |
| hstspreload | 2021.9.1 | 3.6 3.7 3.8 3.9 |
| html2text | 2020.1.16 | 3.6 3.7 3.8 3.9 |
| html5lib | 1.1 | 3.6 3.7 3.8 3.9 |
| httpcore | 0.13.3 | 3.6 |
| httpcore | 0.13.6 | 3.7 3.8 3.9 |
| httpcore | 0.9.1 | 3.6 3.7 3.8 3.9 |
| httpexceptor | 1.4.0 | 3.6 3.7 3.8 3.9 |
| httplib2 | 0.19.1 | 3.6 3.7 3.8 3.9 |
| httpretty | 1.1.4 | 3.6 3.7 3.8 3.9 |
| httptools | 0.3.0 | 3.6 3.7 3.8 3.9 |
| httpx | 0.13.3 | 3.7 3.8 3.9 |
| httpx | 0.19.0 | 3.6 3.7 3.8 3.9 |
| huaweicloudsdkcore | 3.0.60 | 3.6 3.7 3.8 3.9 |
| huggingface-hub | 0.0.16 | 3.6 3.7 3.8 3.9 |
| huggingface-hub | 0.0.17 | 3.6 3.7 3.8 3.9 |
| humanfriendly | 9.2 | 3.6 3.7 3.8 3.9 |
| hupper | 1.10.3 | 3.6 3.7 3.8 3.9 |
| hvac | 0.11.0 | 3.6 3.7 3.8 3.9 |
| hydra-core | 1.1.1 | 3.6 3.7 3.8 3.9 |
| hyperframe | 5.2.0 | 3.6 3.7 3.8 3.9 |
| hyperlink | 21.0.0 | 3.6 3.7 3.8 3.9 |
| hypothesis | 6.20.1 | 3.6 3.7 3.8 3.9 |
| identify | 2.2.14 | 3.7 3.8 3.9 |
| idna | 2.10 | 3.6 3.7 3.8 3.9 |
| idna | 3.2 | 3.6 3.7 3.8 3.9 |
| idna | 3.3 | 3.6 3.7 3.8 3.9 |
| idna-ssl | 1.1.0 | 3.6 |
| ifaddr | 0.1.7 | 3.6 3.7 3.8 3.9 |
| ijson | 3.1.4 | 3.6 3.7 3.8 3.9 |
| imageio | 2.9.0 | 3.6 3.7 3.8 3.9 |
| imagesize | 1.2.0 | 3.6 3.7 3.8 3.9 |
| imapclient | 2.2.0 | 3.6 3.7 3.8 3.9 |
| imbalanced-learn | 0.8.0 | 3.6 3.7 3.8 3.9 |
| imgaug | 0.4.0 | 3.6 3.7 3.8 3.9 |
| immutables | 0.16 | 3.6 |
| importlab | 0.6.1 | 3.6 3.7 3.8 3.9 |
| importlib-metadata | 1.7.0 | 3.6 3.7 |
| importlib-metadata | 4.8.1 | 3.6 3.7 3.8 3.9 |
| importlib-resources | 1.5.0 | 3.6 3.7 3.8 3.9 |
| importlib-resources | 3.3.1 | 3.6 |
| importlib-resources | 5.2.2 | 3.6 3.7 3.8 |
| incremental | 21.3.0 | 3.6 3.7 3.8 3.9 |
| inflect | 5.3.0 | 3.6 3.7 3.8 3.9 |
| inflection | 0.5.1 | 3.6 3.7 3.8 3.9 |
| influxdb | 5.3.1 | 3.6 3.7 3.8 3.9 |
| iniconfig | 1.1.1 | 3.6 3.7 3.8 3.9 |
| in-place | 0.5.0 | 3.6 3.7 3.8 3.9 |
| intake | 0.6.3 | 3.7 3.8 3.9 |
| int-date | 0.1.8 | 3.6 3.7 3.8 3.9 |
| intervaltree | 3.1.0 | 3.6 3.7 3.8 3.9 |
| invoke | 1.6.0 | 3.6 3.7 3.8 3.9 |
| ipaddress | 1.0.23 | 3.6 3.7 3.8 3.9 |
| ipdb | 0.13.9 | 3.6 3.7 3.8 3.9 |
| ipfshttpclient | 0.8.0a2 | 3.8 3.9 |
| ipy | 1.01 | 3.6 3.7 3.8 3.9 |
| ipython | 7.16.1 | 3.6 |
| ipython | 7.27.0 | 3.7 3.8 3.9 |
| ipython-genutils | 0.2.0 | 3.6 3.7 3.8 3.9 |
| iso8601 | 0.1.12 | 3.6 3.7 3.8 3.9 |
| iso8601 | 0.1.16 | 3.6 3.7 3.8 3.9 |
| isodate | 0.6.0 | 3.6 3.7 3.8 3.9 |
| isomer | 1.0.0 | 3.6 3.7 3.8 3.9 |
| isort | 5.8.0 | 3.6 |
| isort | 5.9.3 | 3.7 3.8 3.9 |
| itemadapter | 0.4.0 | 3.6 3.7 3.8 3.9 |
| itemloaders | 1.0.4 | 3.6 3.7 3.8 3.9 |
| itsdangerous | 1.1.0 | 3.6 3.7 3.8 3.9 |
| itsdangerous | 2.0.1 | 3.6 3.7 3.8 3.9 |
| itypes | 1.2.0 | 3.6 3.7 3.8 3.9 |
| janus | 0.6.1 | 3.6 3.7 3.8 3.9 |
| jaraco-classes | 3.2.1 | 3.6 3.7 3.8 3.9 |
| jaraco-collections | 3.4.0 | 3.6 3.7 3.8 3.9 |
| jaraco-functools | 3.3.0 | 3.6 3.7 3.8 3.9 |
| jaraco-packaging | 8.2.1 | 3.6 3.7 3.8 3.9 |
| jaraco-text | 3.5.1 | 3.6 3.7 3.8 3.9 |
| javaproperties | 0.5.2 | 3.6 3.7 3.8 3.9 |
| javaproperties | 0.8.0 | 3.6 3.7 3.8 3.9 |
| jax | 0.2.20 | 3.7 3.8 3.9 |
| jaxlib | 0.1.71 | 3.7 3.8 3.9 |
| jdcal | 1.4.1 | 3.6 3.7 3.8 3.9 |
| jedi | 0.18.0 | 3.6 3.7 3.8 3.9 |
| jeepney | 0.7.1 | 3.6 3.7 3.8 3.9 |
| jellyfish | 0.8.8 | 3.6 3.7 3.8 3.9 |
| jieba | 0.42.1 | 3.6 3.7 3.8 3.9 |
| jinja2 | 2.11.3 | 3.6 3.7 3.8 3.9 |
| jinja2 | 3.0.1 | 3.6 3.7 3.8 3.9 |
| jinja2 | 3.0.2 | 3.6 3.7 3.8 3.9 |
| jinja2-time | 0.2.0 | 3.6 3.7 3.8 3.9 |
| jinja2-webpack | 0.2.0 | 3.6 3.7 3.8 3.9 |
| jinxed | 1.1.0 | 3.6 3.7 3.8 3.9 |
| jmespath | 0.10.0 | 3.6 3.7 3.8 3.9 |
| joblib | 1.0.1 | 3.6 3.7 3.8 3.9 |
| josepy | 1.9.0 | 3.6 3.7 3.8 3.9 |
| js2py | 0.71 | 3.6 3.7 3.8 3.9 |
| jsii | 0.13.4 | 3.7 3.8 3.9 |
| jsii | 1.34.0 | 3.6 3.7 3.8 3.9 |
| jsmin | 2.2.2 | 3.6 3.7 3.8 3.9 |
| json5 | 0.9.6 | 3.7 3.8 3.9 |
| jsondiff | 1.2.0 | 3.6 3.7 3.8 3.9 |
| jsondiff | 1.3.0 | 3.6 3.7 3.8 3.9 |
| jsonfield | 3.1.0 | 3.6 3.7 3.8 3.9 |
| jsonpatch | 1.32 | 3.6 3.7 3.8 3.9 |
| jsonpath-ng | 1.5.3 | 3.6 3.7 3.8 3.9 |
| jsonpath-rw | 1.4.0 | 3.6 3.7 3.8 3.9 |
| jsonpickle | 2.0.0 | 3.6 3.7 3.8 3.9 |
| jsonpointer | 2.1 | 3.6 3.7 3.8 3.9 |
| jsonschema | 2.6.0 | 3.6 3.7 3.8 3.9 |
| jsonschema | 3.2.0 | 3.6 3.7 3.8 3.9 |
| junit-xml | 1.9 | 3.6 3.7 3.8 3.9 |
| jupyter-alabaster-theme | 0.4.0 | 3.6 3.7 3.8 3.9 |
| jupyter-core | 4.8.1 | 3.6 3.7 3.8 3.9 |
| jupyterhub | 1.4.2 | 3.6 3.7 3.8 3.9 |
| jupyterlab-pygments | 0.1.2 | 3.6 3.7 3.8 3.9 |
| jupyterlab-widgets | 1.0.1 | 3.6 3.7 3.8 3.9 |
| jupyterlab-widgets | 1.0.2 | 3.6 3.7 3.8 3.9 |
| jupyter-telemetry | 0.1.0 | 3.6 3.7 3.8 3.9 |
| jupytext | 1.12.0 | 3.6 3.7 3.8 3.9 |
| jwcrypto | 1.0 | 3.6 3.7 3.8 3.9 |
| kazoo | 2.8.0 | 3.6 3.7 3.8 3.9 |
| keras | 2.6.0 | 3.7 3.8 3.9 |
| keras-applications | 1.0.8 | 3.6 3.7 3.8 3.9 |
| keras-preprocessing | 1.1.2 | 3.6 3.7 3.8 3.9 |
| keyboard | 0.13.5 | 3.6 3.7 3.8 3.9 |
| keyring | 21.8.0 | 3.6 3.7 3.8 3.9 |
| keyring | 23.1.0 | 3.6 3.7 3.8 3.9 |
| keyring | 23.2.1 | 3.6 3.7 3.8 3.9 |
| keyrings-alt | 4.1.0 | 3.6 3.7 3.8 3.9 |
| kiwisolver | 1.3.1 | 3.6 |
| kiwisolver | 1.3.2 | 3.7 3.8 3.9 |
| knack | 0.8.2 | 3.6 3.7 3.8 3.9 |
| kombu | 4.6.11 | 3.6 3.7 3.8 3.9 |
| kombu | 5.1.0 | 3.6 3.7 3.8 3.9 |
| kubernetes | 18.20.0 | 3.6 3.7 3.8 3.9 |
| l18n | 2020.6.1 | 3.6 3.7 3.8 3.9 |
| langdetect | 1.0.9 | 3.6 3.7 3.8 3.9 |
| lark-parser | 0.10.1 | 3.6 3.7 3.8 3.9 |
| lark-parser | 0.11.3 | 3.6 3.7 3.8 3.9 |
| latexcodec | 2.0.1 | 3.6 3.7 3.8 3.9 |
| lazy-object-proxy | 1.6.0 | 3.6 3.7 3.8 3.9 |
| lazyutils | 0.3.3 | 3.6 3.7 3.8 3.9 |
| ldap3 | 2.9.1 | 3.6 3.7 3.8 3.9 |
| libcst | 0.3.20 | 3.6 3.7 3.8 3.9 |
| libcst | 0.3.21 | 3.6 3.7 3.8 3.9 |
| libsass | 0.21.0 | 3.6 3.7 3.8 3.9 |
| lightgbm | 3.2.1 | 3.6 3.7 3.8 3.9 |
| linecache2 | 1.0.0 | 3.6 3.7 3.8 3.9 |
| livereload | 2.6.3 | 3.6 3.7 3.8 3.9 |
| lizard | 1.17.9 | 3.6 3.7 3.8 3.9 |
| llvmlite | 0.36.0 | 3.6 3.7 3.8 3.9 |
| llvmlite | 0.37.0 | 3.7 3.8 3.9 |
| lmdb | 1.2.1 | 3.6 3.7 3.8 3.9 |
| lob | 4.2.0 | 3.6 3.7 3.8 3.9 |
| localstack-client | 1.23 | 3.6 3.7 3.8 3.9 |
| locket | 0.2.1 | 3.7 3.8 3.9 |
| lockfile | 0.12.2 | 3.6 3.7 3.8 3.9 |
| logbook | 1.5.3 | 3.6 3.7 3.8 3.9 |
| log-symbols | 0.0.14 | 3.6 3.7 3.8 3.9 |
| loguru | 0.5.3 | 3.6 3.7 3.8 3.9 |
| logzero | 1.7.0 | 3.6 3.7 3.8 3.9 |
| lru-dict | 1.1.7 | 3.8 3.9 |
| luigi | 3.0.3 | 3.7 |
| lxml | 4.6.3 | 3.6 3.7 3.8 3.9 |
| lz4 | 3.1.3 | 3.6 3.7 3.8 3.9 |
| m2r | 0.2.1 | 3.6 3.7 3.8 3.9 |
| m2r2 | 0.3.1 | 3.6 3.7 3.8 3.9 |
| m9s-trytond | 5.2.28 | 3.6 3.7 3.8 3.9 |
| mailchimp-marketing | 3.0.59 | 3.6 3.7 3.8 3.9 |
| mako | 1.1.5 | 3.6 3.7 3.8 3.9 |
| mandrill-really-maintained | 1.2.4 | 3.6 3.7 3.8 3.9 |
| markdown | 3.3.4 | 3.6 3.7 3.8 3.9 |
| markdown2 | 2.4.1 | 3.6 3.7 3.8 3.9 |
| markdown-checklist | 0.4.3 | 3.6 3.7 3.8 3.9 |
| markdown-it-py | 1.1.0 | 3.6 3.7 3.8 3.9 |
| markupsafe | 1.1.1 | 3.6 3.7 3.8 3.9 |
| markupsafe | 2.0.1 | 3.6 3.7 3.8 3.9 |
| marshmallow | 3.13.0 | 3.6 3.7 3.8 3.9 |
| marshmallow-enum | 1.5.1 | 3.6 3.7 3.8 3.9 |
| marshmallow-oneofschema | 3.0.1 | 3.6 3.7 3.8 3.9 |
| marshmallow-polyfield | 5.10 | 3.6 3.7 3.8 3.9 |
| marshmallow-sqlalchemy | 0.23.1 | 3.6 3.7 3.8 3.9 |
| masonite-cli | 2.2.2 | 3.6 3.7 3.8 3.9 |
| matplotlib | 3.3.4 | 3.6 |
| matplotlib | 3.4.3 | 3.7 3.8 3.9 |
| matplotlib-inline | 0.1.2 | 3.7 3.8 3.9 |
| matplotlib-inline | 0.1.3 | 3.7 3.8 3.9 |
| maturin | 0.11.3 | 3.6 3.7 3.8 3.9 |
| maxminddb | 2.0.3 | 3.6 3.7 3.8 3.9 |
| mccabe | 0.6.1 | 3.6 3.7 3.8 3.9 |
| mdit-py-plugins | 0.2.8 | 3.6 3.7 3.8 3.9 |
| mdp | 3.6 | 3.6 3.7 3.8 3.9 |
| mechanicalsoup | 1.1.0 | 3.6 3.7 3.8 3.9 |
| memoize | 1.0.0 | 3.6 3.7 3.8 3.9 |
| memory-profiler | 0.58.0 | 3.6 3.7 3.8 3.9 |
| mergedeep | 1.3.4 | 3.6 3.7 3.8 3.9 |
| meshio | 5.0.0 | 3.7 3.8 3.9 |
| metaloaders | 20.9.2566091 | 3.6 3.7 3.8 3.9 |
| mimeparse | 0.1.3 | 3.6 3.7 3.8 3.9 |
| minio | 7.1.0 | 3.6 3.7 3.8 3.9 |
| mirakuru | 2.4.1 | 3.7 3.8 3.9 |
| missing | 4.1 | 3.6 3.7 3.8 3.9 |
| mistune | 0.8.4 | 3.6 3.7 3.8 3.9 |
| mixpanel | 4.9.0 | 3.6 3.7 3.8 3.9 |
| mkdocs | 1.2.2 | 3.6 3.7 3.8 3.9 |
| mkdocs-autorefs | 0.2.1 | 3.6 3.7 3.8 3.9 |
| mmh3 | 3.0.0 | 3.6 3.7 3.8 3.9 |
| mne | 0.23.4 | 3.6 3.7 3.8 3.9 |
| mnemonic | 0.20 | 3.6 3.7 3.8 3.9 |
| mock | 4.0.3 | 3.6 3.7 3.8 3.9 |
| mockup | 3.2.6 | 3.6 3.7 3.8 3.9 |
| mongoengine | 0.23.1 | 3.6 3.7 3.8 3.9 |
| monotonic | 1.6 | 3.6 3.7 3.8 3.9 |
| monty | 2021.8.17 | 3.7 3.8 3.9 |
| more-itertools | 8.10.0 | 3.6 3.7 3.8 3.9 |
| more-itertools | 8.4.0 | 3.6 3.7 3.8 3.9 |
| more-itertools | 8.8.0 | 3.6 3.7 3.8 3.9 |
| more-itertools | 8.9.0 | 3.6 3.7 3.8 3.9 |
| moto | 2.2.6 | 3.6 3.7 3.8 3.9 |
| motor | 2.5.1 | 3.6 3.7 3.8 3.9 |
| mpmath | 1.2.1 | 3.6 3.7 3.8 3.9 |
| mrcfile | 1.3.0 | 3.6 3.7 3.8 3.9 |
| msal | 1.14.0 | 3.6 3.7 3.8 3.9 |
| msal | 1.15.0 | 3.6 3.7 3.8 3.9 |
| msal-extensions | 0.3.0 | 3.6 3.7 3.8 3.9 |
| msgpack | 1.0.2 | 3.6 3.7 3.8 3.9 |
| msgpack-python | 0.5.6 | 3.6 3.7 3.8 3.9 |
| msprime | 1.0.2 | 3.7 3.8 3.9 |
| msrest | 0.6.21 | 3.6 3.7 3.8 3.9 |
| msrestazure | 0.6.4 | 3.6 3.7 3.8 3.9 |
| multiaddr | 0.0.9 | 3.8 3.9 |
| multidict | 5.1.0 | 3.6 3.7 3.8 3.9 |
| multimapping | 4.1 | 3.6 3.7 3.8 3.9 |
| multipart | 0.2.4 | 3.6 3.7 3.8 3.9 |
| multipledispatch | 0.6.0 | 3.6 3.7 3.8 3.9 |
| multiprocess | 0.70.12.2 | 3.6 3.7 3.8 3.9 |
| multitasking | 0.0.9 | 3.6 3.7 3.8 3.9 |
| murmurhash | 1.0.5 | 3.6 3.7 3.8 3.9 |
| mutagen | 1.45.1 | 3.6 3.7 3.8 3.9 |
| mypy | 0.910 | 3.6 3.7 3.8 3.9 |
| mypy-extensions | 0.4.3 | 3.6 3.7 3.8 3.9 |
| mysql-connector-python | 8.0.26 | 3.6 3.7 3.8 3.9 |
| myst-parser | 0.15.2 | 3.6 3.7 3.8 3.9 |
| napari-plugin-engine | 0.2.0 | 3.7 3.8 3.9 |
| natsort | 7.1.1 | 3.6 3.7 3.8 3.9 |
| nbval | 0.9.6 | 3.6 3.7 3.8 3.9 |
| ndg-httpsclient | 0.5.1 | 3.6 3.7 3.8 3.9 |
| nest-asyncio | 1.5.1 | 3.6 3.7 3.8 3.9 |
| netaddr | 0.8.0 | 3.6 3.7 3.8 3.9 |
| netcdf4 | 1.5.7 | 3.6 3.7 3.8 3.9 |
| netifaces | 0.11.0 | 3.6 3.7 3.8 3.9 |
| netmiko | 3.4.0 | 3.6 3.7 3.8 3.9 |
| netron | 5.2.2 | 3.6 3.7 3.8 3.9 |
| networkx | 2.5.1 | 3.6 |
| networkx | 2.6.2 | 3.7 3.8 3.9 |
| networkx | 2.6.3 | 3.7 3.8 3.9 |
| newick | 1.3.0 | 3.7 3.8 3.9 |
| newrelic | 6.8.1.164 | 3.6 3.7 3.8 3.9 |
| nibabel | 3.2.1 | 3.6 3.7 3.8 3.9 |
| ninja | 1.10.2.2 | 3.6 3.7 3.8 3.9 |
| nltk | 3.6.2 | 3.6 3.7 3.8 3.9 |
| nodeenv | 1.6.0 | 3.7 3.8 3.9 |
| nose | 1.3.7 | 3.6 3.7 3.8 3.9 |
| nose2 | 0.10.0 | 3.6 3.7 3.8 3.9 |
| nose-test-select | 0.3 | 3.6 3.7 3.8 3.9 |
| nosexcover | 1.0.11 | 3.6 3.7 3.8 3.9 |
| nox | 2021.6.12 | 3.6 3.7 3.8 3.9 |
| ntc-templates | 2.3.2 | 3.6 3.7 3.8 3.9 |
| ntlm-auth | 1.5.0 | 3.6 3.7 3.8 3.9 |
| nuitka | 0.6.16.4 | 3.6 3.7 3.8 3.9 |
| numpy | 1.19.5 | 3.6 3.7 3.8 3.9 |
| numpy | 1.20.3 | 3.7 3.8 3.9 |
| numpy | 1.21.2 | 3.7 3.8 3.9 |
| numpydoc | 1.1.0 | 3.6 3.7 3.8 3.9 |
| nvidia-ml-py3 | 7.352.0 | 3.6 3.7 3.8 3.9 |
| oauth2client | 4.1.3 | 3.6 3.7 3.8 3.9 |
| oauthlib | 3.1.1 | 3.6 3.7 3.8 3.9 |
| olefile | 0.46 | 3.6 3.7 3.8 3.9 |
| omegaconf | 2.1.1 | 3.6 3.7 3.8 3.9 |
| on-http-redfish-1-0 | 1.0.9 | 3.6 3.7 3.8 3.9 |
| openapi-schema-validator | 0.1.5 | 3.6 3.7 3.8 3.9 |
| opencensus | 0.7.13 | 3.6 3.7 3.8 3.9 |
| opencensus-context | 0.1.2 | 3.6 3.7 3.8 3.9 |
| opencl4py | 1.5.1 | 3.6 3.7 3.8 3.9 |
| opencv-python | 4.5.2.54 | 3.6 |
| opencv-python | 4.5.3.56 | 3.7 3.8 3.9 |
| opencv-python-headless | 4.5.2.54 | 3.6 |
| opencv-python-headless | 4.5.3.56 | 3.7 3.8 3.9 |
| openpyxl | 3.0.7 | 3.6 3.7 3.8 3.9 |
| opentelemetry-api | 1.5.0 | 3.6 3.7 3.8 3.9 |
| opentelemetry-instrumentation | 0.24b0 | 3.6 3.7 3.8 3.9 |
| opentracing | 2.4.0 | 3.6 3.7 3.8 3.9 |
| opt-einsum | 3.3.0 | 3.6 3.7 3.8 3.9 |
| optuna | 2.9.1 | 3.6 3.7 3.8 3.9 |
| ordereddict | 1.1 | 3.6 3.7 3.8 3.9 |
| orderedmultidict | 1.0.1 | 3.6 3.7 3.8 3.9 |
| ordered-set | 4.0.2 | 3.6 3.7 3.8 3.9 |
| orjson | 3.6.3 | 3.7 3.8 3.9 |
| oscrypto | 1.2.1 | 3.6 3.7 3.8 3.9 |
| oslo-cache | 2.8.1 | 3.6 3.7 3.8 3.9 |
| oslo-concurrency | 4.4.1 | 3.6 3.7 3.8 3.9 |
| oslo-config | 8.7.1 | 3.6 3.7 3.8 3.9 |
| oslo-context | 3.3.1 | 3.6 3.7 3.8 3.9 |
| oslo-i18n | 5.1.0 | 3.6 3.7 3.8 3.9 |
| oslo-log | 4.6.0 | 3.6 3.7 3.8 3.9 |
| oslo-metrics | 0.3.0 | 3.6 3.7 3.8 3.9 |
| oslo-policy | 3.8.2 | 3.6 3.7 3.8 3.9 |
| oslo-serialization | 4.2.0 | 3.6 3.7 3.8 3.9 |
| oslosphinx | 4.18.0 | 3.6 3.7 3.8 3.9 |
| oslo-utils | 4.10.0 | 3.6 3.7 3.8 3.9 |
| outcome | 1.1.0 | 3.6 3.7 3.8 3.9 |
| oyaml | 1.0 | 3.6 3.7 3.8 3.9 |
| packaging | 20.9 | 3.6 3.7 3.8 3.9 |
| packaging | 21.0 | 3.6 3.7 3.8 3.9 |
| paho-mqtt | 1.5.1 | 3.6 3.7 3.8 3.9 |
| pamela | 1.0.0 | 3.6 3.7 3.8 3.9 |
| pamqp | 2.3.0 | 3.6 3.7 3.8 3.9 |
| pandas | 0.25.3 | 3.6 |
| pandas | 1.1.5 | 3.7 |
| pandas | 1.3.2 | 3.8 3.9 |
| pandas | 1.3.3 | 3.8 3.9 |
| pandas-datareader | 0.10.0 | 3.6 3.7 3.8 3.9 |
| pandocfilters | 1.4.3 | 3.6 3.7 3.8 3.9 |
| pandocfilters | 1.5.0 | 3.6 3.7 3.8 3.9 |
| panel | 0.12.1 | 3.6 |
| panel | 0.12.3 | 3.7 3.8 3.9 |
| para | 0.0.8 | 3.6 3.7 3.8 3.9 |
| param | 1.11.1 | 3.6 3.7 3.8 3.9 |
| parameterized | 0.8.1 | 3.6 3.7 3.8 3.9 |
| paramiko | 2.7.2 | 3.6 3.7 3.8 3.9 |
| paramiko | 2.8.0 | 3.6 3.7 3.8 3.9 |
| parse | 1.19.0 | 3.6 3.7 3.8 3.9 |
| parsedatetime | 2.6 | 3.6 3.7 3.8 3.9 |
| parsel | 1.6.0 | 3.6 3.7 3.8 3.9 |
| parse-type | 0.5.2 | 3.6 3.7 3.8 3.9 |
| parsimonious | 0.8.1 | 3.6 3.7 3.8 3.9 |
| parso | 0.8.2 | 3.6 3.7 3.8 3.9 |
| partd | 1.2.0 | 3.7 3.8 3.9 |
| passlib | 1.7.4 | 3.6 3.7 3.8 3.9 |
| paste | 3.5.0 | 3.6 3.7 3.8 3.9 |
| pastedeploy | 2.1.1 | 3.6 3.7 3.8 3.9 |
| pastel | 0.1.1 | 3.6 3.7 3.8 3.9 |
| pastel | 0.2.1 | 3.6 3.7 3.8 3.9 |
| path | 16.2.0 | 3.6 3.7 3.8 3.9 |
| pathlib | 1.0.1 | 3.6 3.7 3.8 3.9 |
| pathlib2 | 2.3.6 | 3.6 3.7 3.8 3.9 |
| pathos | 0.2.8 | 3.6 3.7 3.8 3.9 |
| path-py | 12.5.0 | 3.6 3.7 3.8 3.9 |
| pathspec | 0.9.0 | 3.6 3.7 3.8 3.9 |
| pathtools | 0.1.2 | 3.6 3.7 3.8 3.9 |
| pathvalidate | 2.4.1 | 3.6 3.7 3.8 3.9 |
| pathy | 0.6.0 | 3.6 3.7 3.8 3.9 |
| patsy | 0.5.1 | 3.6 3.7 3.8 3.9 |
| pbr | 5.4.5 | 3.6 3.7 3.8 3.9 |
| pbr | 5.6.0 | 3.6 3.7 3.8 3.9 |
| pdf2image | 1.16.0 | 3.6 3.7 3.8 3.9 |
| pdfminer-six | 20201018 | 3.6 3.7 3.8 3.9 |
| peewee | 3.14.4 | 3.6 3.7 3.8 3.9 |
| pefile | 2021.9.3 | 3.6 3.7 3.8 3.9 |
| pendulum | 2.1.2 | 3.6 3.7 3.8 3.9 |
| pep517 | 0.11.0 | 3.6 3.7 3.8 3.9 |
| pep562 | 1.1 | 3.6 |
| pep8 | 1.7.1 | 3.6 3.7 3.8 3.9 |
| pep8-naming | 0.10.0 | 3.7 3.8 3.9 |
| pep8-naming | 0.12.1 | 3.6 3.7 3.8 3.9 |
| peppercorn | 0.6 | 3.6 3.7 3.8 3.9 |
| persistence | 3.1 | 3.6 3.7 3.8 3.9 |
| persistent | 4.7.0 | 3.6 3.7 3.8 3.9 |
| pexpect | 4.8.0 | 3.6 3.7 3.8 3.9 |
| phonenumbers | 8.12.31 | 3.6 3.7 3.8 3.9 |
| pickleshare | 0.7.5 | 3.6 3.7 3.8 3.9 |
| piexif | 1.1.3 | 3.6 3.7 3.8 3.9 |
| pika | 1.2.0 | 3.6 3.7 3.8 3.9 |
| pillow | 8.3.1 | 3.6 3.7 3.8 3.9 |
| pillow | 8.3.2 | 3.6 3.7 3.8 3.9 |
| pint | 0.17 | 3.6 3.7 3.8 3.9 |
| pip | 21.2.4 |  |
| pip-check | 2.6 | 3.6 3.7 3.8 3.9 |
| pip-check-reqs | 2.3.0 | 3.6 3.7 3.8 3.9 |
| pipenv | 2021.5.29 | 3.6 3.7 3.8 3.9 |
| pip-tools | 6.2.0 | 3.6 3.7 3.8 3.9 |
| pip-upgrader | 1.4.15 | 3.6 3.7 3.8 3.9 |
| pkginfo | 1.7.1 | 3.6 3.7 3.8 3.9 |
| plac | 1.3.3 | 3.6 3.7 3.8 3.9 |
| plantweb | 1.2.1 | 3.6 3.7 3.8 3.9 |
| plaster | 1.0 | 3.6 3.7 3.8 3.9 |
| plaster-pastedeploy | 0.7 | 3.6 3.7 3.8 3.9 |
| platformdirs | 2.3.0 | 3.6 3.7 3.8 3.9 |
| playsound | 1.3.0 | 3.6 3.7 3.8 3.9 |
| plexauth | 0.0.6 | 3.6 3.7 3.8 3.9 |
| plone-alterego | 1.1.5 | 3.6 3.7 3.8 3.9 |
| plone-app-caching | 2.1.0 | 3.6 3.7 3.8 3.9 |
| plone-app-contentlisting | 2.0.4 | 3.6 3.7 3.8 3.9 |
| plone-app-contentmenu | 2.3.4 | 3.6 3.7 3.8 3.9 |
| plone-app-contentrules | 4.1.6 | 3.6 3.7 3.8 3.9 |
| plone-app-customerize | 1.3.11 | 3.6 3.7 3.8 3.9 |
| plone-app-i18n | 3.0.6 | 3.6 3.7 3.8 3.9 |
| plone-app-intid | 1.1.4 | 3.6 3.7 3.8 3.9 |
| plone-app-layout | 3.4.6 | 3.6 3.7 3.8 3.9 |
| plone-app-layout | 4.0.0a3 | 3.6 3.7 3.8 3.9 |
| plone-app-locales | 5.1.29 | 3.6 3.7 3.8 3.9 |
| plone-app-portlets | 4.4.7 | 3.6 3.7 3.8 3.9 |
| plone-app-querystring | 1.4.15 | 3.6 3.7 3.8 3.9 |
| plone-app-redirector | 2.2.1 | 3.6 3.7 3.8 3.9 |
| plone-app-registry | 1.7.9 | 3.6 3.7 3.8 3.9 |
| plone-app-registry | 2.0.0a4 | 3.6 3.7 3.8 3.9 |
| plone-app-textfield | 1.3.5 | 3.6 3.7 3.8 3.9 |
| plone-app-theming | 4.1.7 | 3.6 3.7 3.8 3.9 |
| plone-app-users | 2.6.6 | 3.6 3.7 3.8 3.9 |
| plone-app-uuid | 2.0.2 | 3.6 3.7 3.8 3.9 |
| plone-app-viewletmanager | 3.1.2 | 3.6 3.7 3.8 3.9 |
| plone-app-vocabularies | 4.3.0 | 3.6 3.7 3.8 3.9 |
| plone-app-widgets | 3.0.6 | 3.6 3.7 3.8 3.9 |
| plone-autoform | 1.9.0 | 3.6 3.7 3.8 3.9 |
| plone-batching | 1.1.7 | 3.6 3.7 3.8 3.9 |
| plone-behavior | 1.4.0 | 3.6 3.7 3.8 3.9 |
| plone-browserlayer | 2.2.4 | 3.6 3.7 3.8 3.9 |
| plone-cachepurging | 2.0.3 | 3.6 3.7 3.8 3.9 |
| plone-caching | 1.2.2 | 3.6 3.7 3.8 3.9 |
| plone-contentrules | 2.1.2 | 3.6 3.7 3.8 3.9 |
| plone-event | 1.4.1 | 3.6 3.7 3.8 3.9 |
| plone-folder | 3.1.0 | 3.6 3.7 3.8 3.9 |
| plone-formwidget-recurrence | 2.1.4 | 3.6 3.7 3.8 3.9 |
| plone-i18n | 4.0.6 | 3.6 3.7 3.8 3.9 |
| plone-i18n | 5.0.0a1 | 3.6 3.7 3.8 3.9 |
| plone-indexer | 1.0.7 | 3.6 3.7 3.8 3.9 |
| plone-intelligenttext | 3.1.0 | 3.6 3.7 3.8 3.9 |
| plone-keyring | 3.1.3 | 3.6 3.7 3.8 3.9 |
| plone-locking | 2.2.4 | 3.6 3.7 3.8 3.9 |
| plone-memoize | 2.1.1 | 3.6 3.7 3.8 3.9 |
| plone-outputfilters | 4.0.2 | 3.6 3.7 3.8 3.9 |
| plone-portlet-collection | 3.3.6 | 3.6 3.7 3.8 3.9 |
| plone-portlets | 2.3.2 | 3.6 3.7 3.8 3.9 |
| plone-portlet-static | 3.1.6 | 3.6 3.7 3.8 3.9 |
| plone-protect | 4.1.6 | 3.6 3.7 3.8 3.9 |
| plone-registry | 1.2.1 | 3.6 3.7 3.8 3.9 |
| plone-resource | 2.1.4 | 3.6 3.7 3.8 3.9 |
| plone-resourceeditor | 3.0.3 | 3.6 3.7 3.8 3.9 |
| plone-rfc822 | 2.0.2 | 3.6 3.7 3.8 3.9 |
| plone-scale | 3.1.2 | 3.6 3.7 3.8 3.9 |
| plone-session | 3.7.5 | 3.6 3.7 3.8 3.9 |
| plone-staticresources | 1.4.3 | 3.6 3.7 3.8 3.9 |
| plone-stringinterp | 1.3.3 | 3.6 3.7 3.8 3.9 |
| plone-subrequest | 1.9.3 | 3.6 3.7 3.8 3.9 |
| plone-supermodel | 1.6.4 | 3.6 3.7 3.8 3.9 |
| plone-synchronize | 1.0.4 | 3.6 3.7 3.8 3.9 |
| plone-testing | 8.0.3 | 3.6 3.7 3.8 3.9 |
| plone-theme | 3.0.7 | 3.6 3.7 3.8 3.9 |
| plonetheme-barceloneta | 2.1.10 | 3.6 3.7 3.8 3.9 |
| plone-transformchain | 2.0.2 | 3.6 3.7 3.8 3.9 |
| plone-uuid | 1.0.6 | 3.6 3.7 3.8 3.9 |
| plone-z3cform | 2.0.0a1 | 3.6 3.7 3.8 3.9 |
| plotly | 5.3.1 | 3.6 3.7 3.8 3.9 |
| plotly-express | 0.4.1 | 3.6 3.7 3.8 3.9 |
| plover | 3.1.1 | 3.6 3.7 3.8 3.9 |
| pluggy | 0.13.1 | 3.6 3.7 3.8 3.9 |
| pluggy | 1.0.0 | 3.6 3.7 3.8 3.9 |
| ply | 3.11 | 3.6 3.7 3.8 3.9 |
| plyplus | 0.7.5 | 3.6 3.7 3.8 3.9 |
| pockets | 0.9.1 | 3.6 3.7 3.8 3.9 |
| poetry | 1.1.9 | 3.6 3.7 3.8 3.9 |
| poetry-core | 1.0.5 | 3.6 3.7 3.8 3.9 |
| polib | 1.1.1 | 3.6 3.7 3.8 3.9 |
| pooch | 1.5.1 | 3.6 3.7 3.8 3.9 |
| portalocker | 1.7.1 | 3.6 3.7 3.8 3.9 |
| portalocker | 2.3.2 | 3.6 3.7 3.8 3.9 |
| portend | 2.7.1 | 3.6 3.7 3.8 3.9 |
| port-for | 0.6.1 | 3.7 3.8 3.9 |
| pox | 0.3.0 | 3.6 3.7 3.8 3.9 |
| poyo | 0.5.0 | 3.6 3.7 3.8 3.9 |
| ppft | 1.6.6.4 | 3.6 3.7 3.8 3.9 |
| prawcore | 2.3.0 | 3.6 3.7 3.8 3.9 |
| pre-commit | 2.15.0 | 3.7 3.8 3.9 |
| preshed | 3.0.5 | 3.6 3.7 3.8 3.9 |
| prestring | 0.9.0 | 3.6 3.7 3.8 3.9 |
| pretend | 1.0.9 | 3.6 3.7 3.8 3.9 |
| prettytable | 2.2.0 | 3.6 3.7 3.8 3.9 |
| priority | 1.3.0 | 3.6 3.7 3.8 3.9 |
| prison | 0.2.1 | 3.6 3.7 3.8 3.9 |
| products-btreefolder2 | 4.3 | 3.6 3.7 3.8 3.9 |
| products-cmfcore | 2.5.4 | 3.6 3.7 3.8 3.9 |
| products-cmfdifftool | 3.3.3 | 3.6 3.7 3.8 3.9 |
| products-cmfdynamicviewfti | 6.0.3 | 3.6 3.7 3.8 3.9 |
| products-cmfformcontroller | 4.1.4 | 3.6 3.7 3.8 3.9 |
| products-cmfquickinstallertool | 4.0.4 | 3.6 3.7 3.8 3.9 |
| products-cmfuid | 3.2.0 | 3.6 3.7 3.8 3.9 |
| products-daterecurringindex | 3.0.1 | 3.6 3.7 3.8 3.9 |
| products-dcworkflow | 2.5.0 | 3.6 3.7 3.8 3.9 |
| products-extendedpathindex | 4.0.1 | 3.6 3.7 3.8 3.9 |
| products-externalmethod | 4.5 | 3.6 3.7 3.8 3.9 |
| products-genericsetup | 2.1.4 | 3.6 3.7 3.8 3.9 |
| products-isurlinportal | 1.2.1 | 3.6 3.7 3.8 3.9 |
| products-mailhost | 4.11 | 3.6 3.7 3.8 3.9 |
| products-mimetypesregistry | 2.1.8 | 3.6 3.7 3.8 3.9 |
| products-plonepas | 6.0.8 | 3.6 3.7 3.8 3.9 |
| products-pluggableauthservice | 2.6.4 | 3.6 3.7 3.8 3.9 |
| products-pluginregistry | 1.9 | 3.6 3.7 3.8 3.9 |
| products-portaltransforms | 3.1.12 | 3.6 3.7 3.8 3.9 |
| products-pythonscripts | 4.13 | 3.6 3.7 3.8 3.9 |
| products-sessions | 4.12 | 3.6 3.7 3.8 3.9 |
| products-siteerrorlog | 5.5 | 3.6 3.7 3.8 3.9 |
| products-standardcachemanagers | 4.1.1 | 3.6 3.7 3.8 3.9 |
| products-statusmessages | 5.0.5 | 3.6 3.7 3.8 3.9 |
| products-temporaryfolder | 6.2 | 3.6 3.7 3.8 3.9 |
| products-zcatalog | 6.0 | 3.6 3.7 3.8 3.9 |
| products-zodbmountpoint | 1.2 | 3.6 3.7 3.8 3.9 |
| products-zopeversioncontrol | 2.0.0 | 3.6 3.7 3.8 3.9 |
| profanityfilter | 2.0.6 | 3.6 3.7 3.8 3.9 |
| proglog | 0.1.9 | 3.6 3.7 3.8 3.9 |
| progress | 1.6 | 3.6 3.7 3.8 3.9 |
| progressbar | 2.5 | 3.6 3.7 3.8 3.9 |
| progressbar2 | 3.53.3 | 3.6 3.7 3.8 3.9 |
| prometheus-client | 0.11.0 | 3.6 3.7 3.8 3.9 |
| prometheus-flask-exporter | 0.18.2 | 3.6 3.7 3.8 3.9 |
| promise | 2.3 | 3.6 3.7 3.8 3.9 |
| prompt-toolkit | 1.0.14 | 3.6 3.7 3.8 3.9 |
| prompt-toolkit | 2.0.10 | 3.6 3.7 3.8 3.9 |
| prompt-toolkit | 3.0.20 | 3.7 3.8 3.9 |
| prompt-toolkit | 3.0.3 | 3.6 |
| prospector | 1.5.0.1 | 3.7 3.8 3.9 |
| protego | 0.1.16 | 3.6 3.7 3.8 3.9 |
| protobuf | 3.17.3 | 3.6 3.7 3.8 3.9 |
| protobuf | 3.18.0 | 3.6 3.7 3.8 3.9 |
| protobuf3-to-dict | 0.1.5 | 3.6 3.7 3.8 3.9 |
| proto-plus | 1.19.0 | 3.6 3.7 3.8 3.9 |
| psutil | 5.8.0 | 3.6 3.7 3.8 3.9 |
| psycopg2 | 2.9.1 | 3.6 3.7 3.8 3.9 |
| psycopg2-binary | 2.9.1 | 3.6 3.7 3.8 3.9 |
| ptyprocess | 0.7.0 | 3.6 3.7 3.8 3.9 |
| public | 2020.12.3 | 3.6 3.7 3.8 3.9 |
| publication | 0.0.3 | 3.6 3.7 3.8 3.9 |
| pulp | 2.5.0 | 3.6 3.7 3.8 3.9 |
| pulumi | 3.12.0 | 3.6 3.7 3.8 3.9 |
| purplex | 0.2.4 | 3.6 3.7 3.8 3.9 |
| py | 1.10.0 | 3.6 3.7 3.8 3.9 |
| py4j | 0.10.9 | 3.6 3.7 3.8 3.9 |
| pyaes | 1.6.1 | 3.6 3.7 3.8 3.9 |
| pyaml | 21.8.3 | 3.6 3.7 3.8 3.9 |
| pyarrow | 5.0.0 | 3.6 3.7 3.8 3.9 |
| pyasn1 | 0.4.8 | 3.6 3.7 3.8 3.9 |
| pyasn1-modules | 0.2.8 | 3.6 3.7 3.8 3.9 |
| pybind11 | 2.7.1 | 3.6 3.7 3.8 3.9 |
| pybtex | 0.24.0 | 3.6 3.7 3.8 3.9 |
| pycalver | 202010.1043 | 3.6 3.7 3.8 3.9 |
| pycares | 4.0.0 | 3.6 3.7 3.8 3.9 |
| pycocotools | 2.0.0 | 3.7 3.8 |
| pycodestyle | 2.7.0 | 3.6 3.7 3.8 3.9 |
| pycountry | 20.7.3 | 3.6 3.7 3.8 3.9 |
| pycparser | 2.20 | 3.6 3.7 3.8 3.9 |
| py-cpuinfo | 8.0.0 | 3.6 3.7 3.8 3.9 |
| pycricbuzz | 2.4 | 3.6 3.7 3.8 3.9 |
| pycryptodome | 3.10.1 | 3.6 3.7 3.8 3.9 |
| pycryptodomex | 3.10.1 | 3.6 3.7 3.8 3.9 |
| pyct | 0.4.8 | 3.6 3.7 3.8 3.9 |
| pydantic | 1.7.4 | 3.6 |
| pydantic | 1.8.2 | 3.7 3.8 3.9 |
| pydash | 5.0.2 | 3.6 3.7 3.8 3.9 |
| pydata-sphinx-theme | 0.6.3 | 3.6 3.7 3.8 3.9 |
| pydeprecate | 0.3.1 | 3.7 3.8 3.9 |
| pydeps | 1.9.14 | 3.6 3.7 3.8 3.9 |
| pydicom | 2.2.1 | 3.7 3.8 3.9 |
| pydispatcher | 2.0.5 | 3.6 3.7 3.8 3.9 |
| pydocstyle | 6.1.1 | 3.6 3.7 3.8 3.9 |
| pydot | 1.4.2 | 3.6 3.7 3.8 3.9 |
| pydotplus | 2.0.2 | 3.6 3.7 3.8 3.9 |
| pydriller | 2.0 | 3.6 3.7 3.8 3.9 |
| pydub | 0.25.1 | 3.6 3.7 3.8 3.9 |
| pydyf | 0.1.1 | 3.6 3.7 3.8 3.9 |
| pyecharts | 1.9.0 | 3.6 3.7 3.8 3.9 |
| pyee | 8.2.2 | 3.6 3.7 3.8 3.9 |
| pyelftools | 0.27 | 3.6 3.7 3.8 3.9 |
| pyerfa | 2.0.0 | 3.7 3.8 3.9 |
| pyexcelerate | 0.10.0 | 3.6 3.7 3.8 3.9 |
| pyfaidx | 0.6.2 | 3.6 3.7 3.8 3.9 |
| pyfakefs | 4.5.1 | 3.6 3.7 3.8 3.9 |
| pyflakes | 2.2.0 | 3.7 3.8 3.9 |
| pyflakes | 2.3.1 | 3.6 3.7 3.8 3.9 |
| pyftdi | 0.53.3 | 3.6 3.7 3.8 3.9 |
| pygame | 2.0.1 | 3.6 3.7 3.8 3.9 |
| pygit2 | 1.6.1 | 3.7 3.8 3.9 |
| pygithub | 1.55 | 3.6 3.7 3.8 3.9 |
| pyglet | 1.5.21 | 3.6 3.7 3.8 3.9 |
| pygments | 2.10.0 | 3.6 3.7 3.8 3.9 |
| pyhamcrest | 2.0.2 | 3.6 3.7 3.8 3.9 |
| pyhunter | 1.7 | 3.6 3.7 3.8 3.9 |
| pyinotify | 0.9.6 | 3.6 3.7 3.8 3.9 |
| pyinstaller-hooks-contrib | 2021.3 | 3.6 3.7 3.8 3.9 |
| pyjsparser | 2.7.1 | 3.6 3.7 3.8 3.9 |
| pyjwt | 1.7.1 | 3.6 3.7 3.8 3.9 |
| pyjwt | 2.1.0 | 3.6 3.7 3.8 3.9 |
| pyjwt | 2.2.0 | 3.6 3.7 3.8 3.9 |
| pykka | 3.0.1 | 3.7 3.8 3.9 |
| pykwalify | 1.8.0 | 3.6 3.7 3.8 3.9 |
| pylev | 1.4.0 | 3.6 3.7 3.8 3.9 |
| pylg | 1.3.3 | 3.6 3.7 3.8 3.9 |
| pylint | 2.10.2 | 3.6 3.7 3.8 3.9 |
| pylint-celery | 0.3 | 3.7 3.8 3.9 |
| pylint-django | 2.4.4 | 3.7 3.8 3.9 |
| pylint-flask | 0.6 | 3.7 3.8 3.9 |
| pylint-plugin-utils | 0.6 | 3.7 3.8 3.9 |
| pymc3 | 3.11.4 | 3.7 3.8 3.9 |
| pymdown-extensions | 8.2 | 3.6 3.7 3.8 3.9 |
| pymeeus | 0.5.11 | 3.6 3.7 3.8 3.9 |
| pymongo | 3.12.0 | 3.6 3.7 3.8 3.9 |
| pymssql | 2.2.2 | 3.6 3.7 3.8 3.9 |
| pymsteams | 0.1.15 | 3.6 3.7 3.8 3.9 |
| pymupdf | 1.18.19 | 3.6 3.7 3.8 3.9 |
| pymysql | 0.9.3 | 3.6 3.7 3.8 3.9 |
| pymysql | 1.0.2 | 3.6 3.7 3.8 3.9 |
| pynacl | 1.4.0 | 3.6 3.7 3.8 3.9 |
| pynamodb | 5.1.0 | 3.6 3.7 3.8 3.9 |
| pynvml | 11.0.0 | 3.6 3.7 3.8 3.9 |
| pyomo | 6.1.2 | 3.6 3.7 3.8 3.9 |
| pyopengl | 3.1.5 | 3.6 3.7 3.8 3.9 |
| pyopenssl | 20.0.1 | 3.6 3.7 3.8 3.9 |
| pyopenssl | 21.0.0 | 3.6 3.7 3.8 3.9 |
| pyotp | 2.6.0 | 3.6 3.7 3.8 3.9 |
| pypandoc | 1.6.3 | 3.6 3.7 3.8 3.9 |
| pyparsing | 2.4.7 | 3.6 3.7 3.8 3.9 |
| pypdf2 | 1.26.0 | 3.6 3.7 3.8 3.9 |
| pypdf4 | 1.27.0 | 3.6 3.7 3.8 3.9 |
| pyper | 1.1.2 | 3.6 3.7 3.8 3.9 |
| pyperclip | 1.8.2 | 3.6 3.7 3.8 3.9 |
| pyphen | 0.11.0 | 3.6 3.7 3.8 3.9 |
| pypinyin | 0.42.0 | 3.6 3.7 3.8 3.9 |
| pypng | 0.0.21 | 3.6 3.7 3.8 3.9 |
| pyppeteer | 0.0.25 | 3.6 |
| pyppeteer | 0.2.6 | 3.7 3.8 3.9 |
| pypydispatcher | 2.1.2 | 3.6 3.7 3.8 3.9 |
| pyqrcode | 1.2.1 | 3.6 3.7 3.8 3.9 |
| pyqt5 | 5.15.4 | 3.6 3.7 3.8 3.9 |
| pyqt5-qt5 | 5.15.2 | 3.6 3.7 3.8 3.9 |
| pyqt5-sip | 12.9.0 | 3.6 3.7 3.8 3.9 |
| pyqtwebengine | 5.15.4 | 3.6 3.7 3.8 3.9 |
| pyqtwebengine-qt5 | 5.15.2 | 3.6 3.7 3.8 3.9 |
| pyquery | 1.4.3 | 3.6 3.7 3.8 3.9 |
| pyramid | 2.0 | 3.6 3.7 3.8 3.9 |
| pyrect | 0.1.4 | 3.6 3.7 3.8 3.9 |
| pyrelic | 0.8.0 | 3.6 3.7 3.8 3.9 |
| pyrepl | 0.9.0 | 3.6 3.7 3.8 3.9 |
| pyrfc3339 | 1.1 | 3.6 3.7 3.8 3.9 |
| pyrsistent | 0.18.0 | 3.6 3.7 3.8 3.9 |
| pyserial | 3.5 | 3.6 3.7 3.8 3.9 |
| pysftp | 0.2.9 | 3.6 3.7 3.8 3.9 |
| pyshp | 2.1.3 | 3.7 3.8 3.9 |
| pysocks | 1.7.1 | 3.6 3.7 3.8 3.9 |
| pyspark | 3.1.2 | 3.6 3.7 3.8 3.9 |
| pystache | 0.5.4 | 3.6 3.7 3.8 3.9 |
| pytesseract | 0.3.8 | 3.6 3.7 3.8 3.9 |
| pytest | 5.4.3 | 3.6 3.7 3.8 3.9 |
| pytest | 6.2.4 | 3.6 3.7 3.8 3.9 |
| pytest | 6.2.5 | 3.6 3.7 3.8 3.9 |
| pytest-aiohttp | 0.3.0 | 3.6 3.7 3.8 3.9 |
| pytest-asyncio | 0.12.0 | 3.6 3.7 3.8 3.9 |
| pytest-asyncio | 0.15.1 | 3.6 3.7 3.8 3.9 |
| pytest-benchmark | 3.4.1 | 3.6 3.7 3.8 3.9 |
| pytest-cache | 1.0 | 3.6 3.7 3.8 3.9 |
| pytest-check-links | 0.5.2 | 3.6 3.7 3.8 3.9 |
| pytest-cov | 2.12.1 | 3.6 3.7 3.8 3.9 |
| pytest-datadir | 1.3.1 | 3.6 3.7 3.8 3.9 |
| pytest-django | 4.4.0 | 3.6 3.7 3.8 3.9 |
| pytest-flake8 | 1.0.7 | 3.6 3.7 3.8 3.9 |
| pytest-flask | 1.2.0 | 3.6 3.7 3.8 3.9 |
| pytest-forked | 1.3.0 | 3.6 3.7 3.8 3.9 |
| pytest-freezegun | 0.4.2 | 3.6 3.7 3.8 3.9 |
| pytest-html | 3.1.1 | 3.6 3.7 3.8 3.9 |
| pytest-invenio | 1.4.2 | 3.6 3.7 3.8 3.9 |
| pytest-isort | 2.0.0 | 3.6 3.7 3.8 3.9 |
| pytest-metadata | 1.11.0 | 3.6 3.7 3.8 3.9 |
| pytest-mock | 3.6.1 | 3.6 3.7 3.8 3.9 |
| pytest-mpl | 0.13 | 3.6 3.7 3.8 3.9 |
| pytest-mypy | 0.8.1 | 3.6 3.7 3.8 3.9 |
| pytest-postgresql | 3.1.1 | 3.7 3.8 3.9 |
| pytest-pycodestyle | 2.2.0 | 3.6 3.7 3.8 3.9 |
| pytest-pydocstyle | 2.2.0 | 3.6 3.7 3.8 3.9 |
| pytest-randomly | 3.10.1 | 3.6 3.7 3.8 3.9 |
| pytest-random-order | 1.0.4 | 3.6 3.7 3.8 3.9 |
| pytest-rerunfailures | 10.1 | 3.6 3.7 3.8 3.9 |
| pytest-runner | 5.3.1 | 3.6 3.7 3.8 3.9 |
| pytest-sugar | 0.9.4 | 3.6 3.7 3.8 3.9 |
| pytest-test-groups | 1.0.3 | 3.6 3.7 3.8 3.9 |
| pytest-timeout | 1.4.2 | 3.6 3.7 3.8 3.9 |
| pytest-toolbox | 0.4 | 3.6 3.7 3.8 3.9 |
| pytest-watch | 4.2.0 | 3.6 3.7 3.8 3.9 |
| pytest-xdist | 2.3.0 | 3.6 3.7 3.8 3.9 |
| python3-openid | 3.2.0 | 3.6 3.7 3.8 3.9 |
| python3-xlib | 0.15 | 3.6 3.7 3.8 3.9 |
| python-baseconv | 1.2.2 | 3.6 3.7 3.8 3.9 |
| python-box | 5.4.1 | 3.6 3.7 3.8 3.9 |
| python-constraint | 1.4.0 | 3.6 3.7 3.8 3.9 |
| python-consul | 1.1.0 | 3.6 3.7 3.8 3.9 |
| python-coveralls | 2.9.3 | 3.6 3.7 3.8 3.9 |
| python-crontab | 2.5.1 | 3.6 3.7 3.8 3.9 |
| python-daemon | 2.3.0 | 3.6 3.7 3.8 3.9 |
| python-dateutil | 2.8.2 | 3.6 3.7 3.8 3.9 |
| python-decouple | 3.4 | 3.6 3.7 3.8 3.9 |
| python-docx | 0.8.11 | 3.6 3.7 3.8 3.9 |
| python-dotenv | 0.19.0 | 3.6 3.7 3.8 3.9 |
| python-editor | 1.0.4 | 3.6 3.7 3.8 3.9 |
| python-engineio | 4.2.1 | 3.6 3.7 3.8 3.9 |
| python-gettext | 4.0 | 3.6 3.7 3.8 3.9 |
| python-git | 2018.2.1 | 3.6 3.7 3.8 3.9 |
| python-gitlab | 2.10.1 | 3.6 3.7 3.8 3.9 |
| python-gnupg | 0.4.7 | 3.6 3.7 3.8 3.9 |
| python-hcl2 | 3.0.1 | 3.6 3.7 3.8 3.9 |
| python-hosts | 1.0.1 | 3.6 3.7 3.8 3.9 |
| python-http-client | 3.3.2 | 3.6 3.7 3.8 3.9 |
| python-jose | 3.3.0 | 3.6 3.7 3.8 3.9 |
| python-json-logger | 2.0.2 | 3.6 3.7 3.8 3.9 |
| python-magic | 0.4.24 | 3.6 3.7 3.8 3.9 |
| python-memcached | 1.59 | 3.6 3.7 3.8 3.9 |
| python-multipart | 0.0.5 | 3.6 3.7 3.8 3.9 |
| python-rapidjson | 1.4 | 3.6 3.7 3.8 3.9 |
| python-slugify | 4.0.1 | 3.6 3.7 3.8 3.9 |
| python-slugify | 5.0.2 | 3.6 3.7 3.8 3.9 |
| python-socketio | 5.4.0 | 3.6 3.7 3.8 3.9 |
| python-sql | 1.2.2 | 3.6 3.7 3.8 3.9 |
| python-sql | 1.3.0 | 3.6 3.7 3.8 3.9 |
| python-stdnum | 1.16 | 3.6 3.7 3.8 3.9 |
| python-utils | 2.5.6 | 3.6 3.7 3.8 3.9 |
| python-whois | 0.7.3 | 3.6 3.7 3.8 3.9 |
| python-xlib | 0.31 | 3.6 3.7 3.8 3.9 |
| pytimeparse | 1.1.8 | 3.6 3.7 3.8 3.9 |
| pytodoist | 2.1.4 | 3.6 3.7 3.8 3.9 |
| pytoml | 0.1.21 | 3.6 3.7 3.8 3.9 |
| pytorch-lightning | 1.4.7 | 3.7 3.8 3.9 |
| pytube | 11.0.1 | 3.6 3.7 3.8 3.9 |
| pytweening | 1.0.3 | 3.6 3.7 3.8 3.9 |
| pytweening | 1.0.4 | 3.6 3.7 3.8 3.9 |
| pytype | 2021.10.4 | 3.6 3.7 3.8 3.9 |
| pytz | 2019.1 | 3.6 3.7 3.8 3.9 |
| pytz | 2021.1 | 3.6 3.7 3.8 3.9 |
| pytz | 2021.3 | 3.6 3.7 3.8 3.9 |
| pytzdata | 2020.1 | 3.6 3.7 3.8 3.9 |
| pyusb | 1.2.1 | 3.6 3.7 3.8 3.9 |
| pyvisa | 1.11.3 | 3.6 3.7 3.8 3.9 |
| pyviz-comms | 2.1.0 | 3.6 3.7 3.8 3.9 |
| pyvo | 1.1 | 3.6 3.7 3.8 3.9 |
| pywavelets | 1.1.1 | 3.6 3.7 3.8 3.9 |
| pywin32-ctypes | 0.2.0 | 3.6 3.7 3.8 3.9 |
| pyxdg | 0.27 | 3.6 3.7 3.8 3.9 |
| pyyaml | 5.4.1 | 3.6 3.7 3.8 3.9 |
| pyyaml | 6.0 | 3.6 3.7 3.8 3.9 |
| pyyaml-env-tag | 0.1 | 3.6 3.7 3.8 3.9 |
| pyzmq | 22.2.1 | 3.6 3.7 3.8 3.9 |
| pyzmq | 22.3.0 | 3.6 3.7 3.8 3.9 |
| qdldl | 0.1.5.post0 | 3.6 3.7 3.8 3.9 |
| qrcode | 7.3 | 3.6 3.7 3.8 3.9 |
| quandl | 3.6.1 | 3.6 3.7 3.8 3.9 |
| querystring-parser | 1.2.4 | 3.6 3.7 3.8 3.9 |
| questionary | 1.10.0 | 3.6 3.7 3.8 3.9 |
| queuelib | 1.6.2 | 3.6 3.7 3.8 3.9 |
| rad | 0.1.2 | 3.6 3.7 3.8 3.9 |
| random2 | 1.0.1 | 3.6 3.7 3.8 3.9 |
| ratelim | 0.1.6 | 3.8 3.9 |
| ratelimit | 2.2.1 | 3.6 3.7 3.8 3.9 |
| ratelimiter | 1.2.0.post0 | 3.6 3.7 3.8 3.9 |
| raven | 6.10.0 | 3.6 3.7 3.8 3.9 |
| ray | 1.6.0 | 3.6 3.7 3.8 3.9 |
| rdflib | 5.0.0 | 3.6 |
| rdflib | 6.0.0 | 3.7 3.8 3.9 |
| rdflib | 6.0.1 | 3.7 3.8 3.9 |
| rdflib-jsonld | 0.6.2 | 3.6 3.7 3.8 3.9 |
| readchar | 2.0.1 | 3.6 3.7 3.8 3.9 |
| readme-renderer | 29.0 | 3.6 3.7 3.8 3.9 |
| recommonmark | 0.7.1 | 3.6 3.7 3.8 3.9 |
| record | 3.5 | 3.6 3.7 3.8 3.9 |
| redis | 3.5.3 | 3.6 3.7 3.8 3.9 |
| redis-py-cluster | 2.1.3 | 3.6 3.7 3.8 3.9 |
| regetron | 1.4 | 3.6 3.7 3.8 3.9 |
| regex | 2021.8.28 | 3.6 3.7 3.8 3.9 |
| relatorio | 0.10.0 | 3.6 3.7 3.8 3.9 |
| relatorio | 0.9.3 | 3.6 3.7 3.8 3.9 |
| reportlab | 3.6.1 | 3.6 3.7 3.8 3.9 |
| repoze-lru | 0.7 | 3.6 3.7 3.8 3.9 |
| repoze-xmliter | 0.6 | 3.6 3.7 3.8 3.9 |
| requests | 2.25.1 | 3.6 3.7 3.8 3.9 |
| requests | 2.26.0 | 3.6 3.7 3.8 3.9 |
| requests-cache | 0.8.0 | 3.7 3.8 3.9 |
| requestsexceptions | 1.4.0 | 3.6 3.7 3.8 3.9 |
| requests-file | 1.5.1 | 3.6 3.7 3.8 3.9 |
| requests-futures | 1.0.0 | 3.6 3.7 3.8 3.9 |
| requests-html | 0.10.0 | 3.6 3.7 3.8 3.9 |
| requests-mock | 1.9.3 | 3.6 3.7 3.8 3.9 |
| requests-ntlm | 1.1.0 | 3.6 3.7 3.8 3.9 |
| requests-oauthlib | 1.3.0 | 3.6 3.7 3.8 3.9 |
| requests-toolbelt | 0.9.1 | 3.6 3.7 3.8 3.9 |
| requests-unixsocket | 0.2.0 | 3.7 3.8 3.9 |
| requirements-detector | 0.7 | 3.7 3.8 3.9 |
| resolvelib | 0.5.5 | 3.6 3.7 3.8 3.9 |
| responses | 0.13.4 | 3.6 3.7 3.8 3.9 |
| restrictedpython | 5.1 | 3.6 3.7 3.8 3.9 |
| restructuredtext-lint | 1.3.2 | 3.6 3.7 3.8 3.9 |
| retry | 0.9.2 | 3.6 3.7 3.8 3.9 |
| retrying | 1.3.3 | 3.6 3.7 3.8 3.9 |
| returns | 0.16.0 | 3.7 3.8 3.9 |
| retworkx | 0.10.2 | 3.6 3.7 3.8 3.9 |
| rfc3986 | 1.5.0 | 3.6 3.7 3.8 3.9 |
| rfc3987 | 1.3.8 | 3.6 3.7 3.8 3.9 |
| rgbxy | 0.5 | 3.6 3.7 3.8 3.9 |
| rich | 10.12.0 | 3.7 3.8 3.9 |
| rich | 10.9.0 | 3.6 3.7 3.8 3.9 |
| rjsmin | 1.1.0 | 3.6 3.7 3.8 3.9 |
| robotframework | 4.1.1 | 3.6 3.7 3.8 3.9 |
| roman | 3.3 | 3.6 3.7 3.8 3.9 |
| rope | 0.19.0 | 3.6 3.7 3.8 3.9 |
| routes | 2.5.1 | 3.6 3.7 3.8 3.9 |
| rq | 1.9.0 | 3.6 3.7 3.8 3.9 |
| rsa | 4.7.2 | 3.6 3.7 3.8 3.9 |
| rst-linker | 2.2.0 | 3.6 3.7 3.8 3.9 |
| ruamel-yaml | 0.17.16 | 3.6 3.7 3.8 3.9 |
| ruamel-yaml | 0.17.4 | 3.6 3.7 3.8 |
| ruamel-yaml-clib | 0.2.6 | 3.6 3.7 3.8 3.9 |
| rubicon-objc | 0.4.1 | 3.6 3.7 3.8 3.9 |
| rx | 1.6.1 | 3.6 3.7 3.8 3.9 |
| s3fs | 2021.8.1 | 3.6 3.7 3.8 3.9 |
| s3transfer | 0.3.7 | 3.6 3.7 3.8 3.9 |
| s3transfer | 0.4.2 | 3.6 3.7 3.8 3.9 |
| s3transfer | 0.5.0 | 3.6 3.7 3.8 3.9 |
| sacremoses | 0.0.45 | 3.6 3.7 3.8 3.9 |
| safety | 1.10.3 | 3.6 3.7 3.8 3.9 |
| sagemaker | 2.56.0 | 3.6 3.7 3.8 3.9 |
| sanic | 21.6.2 | 3.7 3.8 3.9 |
| sanic-routing | 0.7.1 | 3.7 3.8 3.9 |
| scandir | 1.10.0 | 3.6 3.7 3.8 3.9 |
| scapy | 2.4.5 | 3.6 3.7 3.8 3.9 |
| schedule | 1.1.0 | 3.6 3.7 3.8 3.9 |
| schema | 0.7.4 | 3.6 3.7 3.8 3.9 |
| schematics | 2.1.1 | 3.6 3.7 3.8 3.9 |
| scikit-image | 0.17.2 | 3.6 |
| scikit-image | 0.18.3 | 3.7 3.8 3.9 |
| scikit-learn | 0.24.2 | 3.6 3.7 3.8 3.9 |
| scikit-optimize | 0.8.1 | 3.6 3.7 3.8 3.9 |
| scipy | 1.5.4 | 3.6 |
| scipy | 1.7.1 | 3.7 3.8 3.9 |
| scp | 0.13.6 | 3.6 3.7 3.8 3.9 |
| scp | 0.14.1 | 3.6 3.7 3.8 3.9 |
| scrapy | 2.5.0 | 3.7 3.8 3.9 |
| scripttest | 1.3 | 3.6 3.7 3.8 3.9 |
| scrypt | 0.8.18 | 3.6 3.7 3.8 3.9 |
| seaborn | 0.11.2 | 3.6 3.7 3.8 3.9 |
| secretstorage | 3.3.1 | 3.6 3.7 3.8 3.9 |
| selenium | 3.141.0 | 3.6 3.7 3.8 3.9 |
| semantic-version | 2.8.5 | 3.6 3.7 3.8 3.9 |
| semver | 2.13.0 | 3.6 3.7 3.8 3.9 |
| send2trash | 1.8.0 | 3.6 3.7 3.8 3.9 |
| sentencepiece | 0.1.96 | 3.6 3.7 3.8 3.9 |
| sentence-transformers | 2.0.0 | 3.7 3.8 3.9 |
| sentry-sdk | 1.3.1 | 3.6 3.7 3.8 3.9 |
| service-identity | 21.1.0 | 3.6 3.7 3.8 3.9 |
| setoptconf | 0.2.0 | 3.7 3.8 3.9 |
| setproctitle | 1.2.2 | 3.6 3.7 3.8 3.9 |
| setuptools | 57.4.0 | 3.6 3.7 3.8 3.9 |
| setuptools | 57.5.0 | 3.6 3.7 3.8 3.9 |
| setuptools | 58.2.0 | 3.6 3.7 3.8 3.9 |
| setuptools-rust | 0.12.1 | 3.6 3.7 3.8 3.9 |
| sgmllib3k | 1.0.0 | 3.6 3.7 3.8 3.9 |
| sgqlc | 14.0 | 3.6 3.7 3.8 3.9 |
| sh | 1.14.2 | 3.6 3.7 3.8 3.9 |
| shapely | 1.7.1 | 3.6 3.7 3.8 3.9 |
| sharedmem | 0.3.8 | 3.6 3.7 3.8 3.9 |
| shellingham | 1.4.0 | 3.6 3.7 3.8 3.9 |
| shortuuid | 1.0.1 | 3.6 3.7 3.8 3.9 |
| sign | 0.0.2 | 3.6 3.7 3.8 3.9 |
| simpleeval | 0.9.10 | 3.6 3.7 3.8 3.9 |
| simplegeneric | 0.8.1 | 3.6 3.7 3.8 3.9 |
| simplejson | 3.11.1 | 3.6 3.7 3.8 3.9 |
| simplejson | 3.17.5 | 3.6 3.7 3.8 3.9 |
| sinfo | 0.3.4 | 3.7 3.8 3.9 |
| singledispatch | 3.7.0 | 3.6 3.7 3.8 3.9 |
| six | 1.15.0 | 3.6 3.7 3.8 3.9 |
| six | 1.16.0 | 3.6 3.7 3.8 3.9 |
| skills | 0.3.0 | 3.6 3.7 3.8 3.9 |
| sklearn | 0.0 | 3.6 3.7 3.8 3.9 |
| slackclient | 2.9.3 | 3.6 3.7 3.8 3.9 |
| slacker | 0.14.0 | 3.6 3.7 3.8 3.9 |
| slicer | 0.0.7 | 3.6 3.7 3.8 3.9 |
| smart-open | 5.2.1 | 3.6 3.7 3.8 3.9 |
| smbus2 | 0.4.1 | 3.6 3.7 3.8 3.9 |
| smdebug-rulesconfig | 1.0.1 | 3.6 3.7 3.8 3.9 |
| smmap | 4.0.0 | 3.6 3.7 3.8 3.9 |
| snaptime | 0.2.4 | 3.6 3.7 3.8 3.9 |
| sniffio | 1.2.0 | 3.6 3.7 3.8 3.9 |
| snowballstemmer | 2.1.0 | 3.6 3.7 3.8 3.9 |
| snowflake-connector-python | 2.6.1 | 3.6 3.7 3.8 3.9 |
| snuggs | 1.4.7 | 3.6 3.7 3.8 3.9 |
| social-auth-core | 4.1.0 | 3.6 3.7 3.8 3.9 |
| sockjs | 0.11.0 | 3.6 3.7 3.8 3.9 |
| sortedcontainers | 2.4.0 | 3.6 3.7 3.8 3.9 |
| sounddevice | 0.4.2 | 3.6 3.7 3.8 3.9 |
| soundfile | 0.10.3.post1 | 3.6 3.7 3.8 3.9 |
| soupsieve | 2.2.1 | 3.6 3.7 3.8 3.9 |
| south | 1.0.2 | 3.6 3.7 3.8 3.9 |
| spacy | 3.1.2 | 3.6 3.7 3.8 3.9 |
| spacy-legacy | 3.0.8 | 3.6 3.7 3.8 3.9 |
| speaklater | 1.3 | 3.6 3.7 3.8 3.9 |
| speechrecognition | 3.8.1 | 3.6 3.7 3.8 3.9 |
| spglib | 1.16.2 | 3.7 3.8 3.9 |
| sphinx | 4.1.2 | 3.6 3.7 3.8 3.9 |
| sphinx | 4.2.0 | 3.6 3.7 3.8 3.9 |
| sphinx-argparse | 0.3.1 | 3.6 3.7 3.8 3.9 |
| sphinx-autoapi | 1.8.4 | 3.6 3.7 3.8 3.9 |
| sphinx-autobuild | 2021.3.14 | 3.6 3.7 3.8 3.9 |
| sphinx-autodoc-typehints | 1.12.0 | 3.6 3.7 3.8 3.9 |
| sphinx-automodapi | 0.13 | 3.6 3.7 3.8 3.9 |
| sphinx-bootstrap-theme | 0.8.0 | 3.6 3.7 3.8 3.9 |
| sphinx-click | 3.0.1 | 3.6 3.7 3.8 3.9 |
| sphinxcontrib-apidoc | 0.3.0 | 3.6 3.7 3.8 3.9 |
| sphinxcontrib-applehelp | 1.0.2 | 3.6 3.7 3.8 3.9 |
| sphinxcontrib-bibtex | 2.4.1 | 3.6 3.7 3.8 3.9 |
| sphinxcontrib-devhelp | 1.0.2 | 3.6 3.7 3.8 3.9 |
| sphinxcontrib-htmlhelp | 2.0.0 | 3.6 3.7 3.8 3.9 |
| sphinxcontrib-jsmath | 1.0.1 | 3.6 3.7 3.8 3.9 |
| sphinxcontrib-napoleon | 0.7 | 3.6 3.7 3.8 3.9 |
| sphinxcontrib-programoutput | 0.17 | 3.6 3.7 3.8 3.9 |
| sphinxcontrib-qthelp | 1.0.3 | 3.6 3.7 3.8 3.9 |
| sphinxcontrib-serializinghtml | 1.1.5 | 3.6 3.7 3.8 3.9 |
| sphinxcontrib-websupport | 1.2.4 | 3.6 3.7 3.8 3.9 |
| sphinx-copybutton | 0.4.0 | 3.6 3.7 3.8 3.9 |
| sphinx-gallery | 0.9.0 | 3.6 3.7 3.8 3.9 |
| sphinx-rtd-theme | 0.5.2 | 3.6 3.7 3.8 3.9 |
| spinners | 0.0.24 | 3.6 3.7 3.8 3.9 |
| spotipy | 2.19.0 | 3.6 3.7 3.8 3.9 |
| sqlalchemy | 1.3.24 | 3.6 3.7 3.8 3.9 |
| sqlalchemy | 1.4.23 | 3.6 3.7 3.8 3.9 |
| sqlalchemy-jsonfield | 1.0.0 | 3.6 3.7 3.8 3.9 |
| sqlalchemy-mixins | 1.5 | 3.6 3.7 3.8 3.9 |
| sqlalchemy-utils | 0.37.8 | 3.6 3.7 3.8 3.9 |
| sqlite-fts4 | 1.0.1 | 3.6 3.7 3.8 3.9 |
| sqlite-utils | 3.17 | 3.6 3.7 3.8 3.9 |
| sqlparse | 0.4.1 | 3.6 3.7 3.8 3.9 |
| sqlparse | 0.4.2 | 3.6 3.7 3.8 3.9 |
| srsly | 2.4.1 | 3.6 3.7 3.8 3.9 |
| sshtunnel | 0.1.5 | 3.6 3.7 3.8 3.9 |
| sshtunnel | 0.4.0 | 3.6 3.7 3.8 3.9 |
| stanfordnlp | 0.2.0 | 3.7 3.8 3.9 |
| starkbank-ecdsa | 1.1.1 | 3.6 3.7 3.8 3.9 |
| starlette | 0.14.2 | 3.6 3.7 3.8 3.9 |
| starlette | 0.16.0 | 3.7 3.8 3.9 |
| statsd | 3.3.0 | 3.6 3.7 3.8 3.9 |
| statsmodels | 0.12.2 | 3.6 3.7 3.8 3.9 |
| statsmodels | 0.13.0rc0 | 3.7 3.8 3.9 |
| stdlib-list | 0.8.0 | 3.6 3.7 3.8 3.9 |
| stevedore | 3.4.0 | 3.6 3.7 3.8 3.9 |
| stomper | 0.4.3 | 3.6 3.7 3.8 3.9 |
| stone | 3.2.1 | 3.6 3.7 3.8 3.9 |
| strict-rfc3339 | 0.7 | 3.6 3.7 3.8 3.9 |
| stringcase | 1.2.0 | 3.6 3.7 3.8 3.9 |
| stripe | 2.60.0 | 3.6 3.7 3.8 3.9 |
| structlog | 21.1.0 | 3.6 3.7 3.8 3.9 |
| subprocess32 | 3.5.4 | 3.6 3.7 3.8 3.9 |
| suds-jurko | 0.6 | 3.6 3.7 3.8 3.9 |
| supervisor | 4.2.2 | 3.6 3.7 3.8 3.9 |
| svgwrite | 1.4.1 | 3.7 3.8 3.9 |
| swagger-ui-bundle | 0.0.8 | 3.6 3.7 3.8 3.9 |
| symengine | 0.8.1 | 3.6 3.7 3.8 3.9 |
| sympy | 1.8 | 3.6 3.7 3.8 3.9 |
| tablib | 3.0.0 | 3.6 3.7 3.8 3.9 |
| tabulate | 0.8.9 | 3.6 3.7 3.8 3.9 |
| tblib | 1.7.0 | 3.7 3.8 3.9 |
| telepath | 0.2 | 3.6 3.7 3.8 3.9 |
| telethon | 1.23.0 | 3.6 3.7 3.8 3.9 |
| tempita | 0.5.2 | 3.6 3.7 3.8 3.9 |
| tempora | 4.1.1 | 3.6 3.7 3.8 3.9 |
| tempstorage | 5.2 | 3.6 3.7 3.8 3.9 |
| tenacity | 6.2.0 | 3.6 3.7 3.8 3.9 |
| tenacity | 6.3.1 | 3.7 |
| tenacity | 8.0.1 | 3.6 3.7 3.8 3.9 |
| tensorboard | 2.6.0 | 3.6 3.7 3.8 3.9 |
| tensorboard-data-server | 0.6.1 | 3.6 3.7 3.8 3.9 |
| tensorboard-plugin-wit | 1.8.0 | 3.6 3.7 3.8 3.9 |
| tensorflow | 2.6.0 | 3.7 3.8 3.9 |
| tensorflow-estimator | 2.6.0 | 3.7 3.8 3.9 |
| tensorflow-metadata | 1.2.0 | 3.6 3.7 3.8 3.9 |
| tensorflow-probability | 0.13.0 | 3.6 3.7 3.8 3.9 |
| termcolor | 1.1.0 | 3.6 3.7 3.8 3.9 |
| terminaltables | 3.1.0 | 3.6 3.7 3.8 3.9 |
| testfixtures | 6.18.1 | 3.6 3.7 3.8 3.9 |
| testpath | 0.5.0 | 3.6 3.7 3.8 3.9 |
| textblob | 0.15.3 | 3.6 3.7 3.8 3.9 |
| textfsm | 1.1.2 | 3.6 3.7 3.8 3.9 |
| textrazor | 1.4.0 | 3.6 3.7 3.8 3.9 |
| texttable | 1.6.4 | 3.6 3.7 3.8 3.9 |
| textual | 0.1.12 | 3.7 3.8 3.9 |
| text-unidecode | 1.3 | 3.6 3.7 3.8 3.9 |
| textwrap3 | 0.9.2 | 3.6 3.7 3.8 3.9 |
| the | 0.1.5 | 3.6 3.7 3.8 3.9 |
| theano | 1.0.5 | 3.6 3.7 3.8 3.9 |
| theano-pymc | 1.1.2 | 3.7 3.8 3.9 |
| therapist | 2.2.0 | 3.6 3.7 3.8 3.9 |
| thinc | 8.0.10 | 3.6 3.7 3.8 3.9 |
| thop | 0.0.31-2005241907 | 3.7 3.8 3.9 |
| threadpoolctl | 2.2.0 | 3.6 3.7 3.8 3.9 |
| thrift | 0.13.0 | 3.6 3.7 3.8 3.9 |
| tifffile | 2020.9.3 | 3.6 |
| tifffile | 2021.8.30 | 3.7 3.8 3.9 |
| timeout-decorator | 0.5.0 | 3.6 3.7 3.8 3.9 |
| timestamp | 0.0.1 | 3.6 3.7 3.8 3.9 |
| tinycss2 | 1.1.0 | 3.6 3.7 3.8 3.9 |
| tinydb | 4.5.1 | 3.6 3.7 3.8 3.9 |
| tldextract | 3.1.2 | 3.6 3.7 3.8 3.9 |
| tlslite-ng | 0.7.6 | 3.6 3.7 3.8 3.9 |
| tls-parser | 1.2.2 | 3.6 3.7 3.8 3.9 |
| tokenizers | 0.10.3 | 3.6 3.7 3.8 3.9 |
| toml | 0.10.2 | 3.6 3.7 3.8 3.9 |
| tomli | 1.2.1 | 3.6 3.7 3.8 3.9 |
| tomlkit | 0.7.2 | 3.6 3.7 3.8 3.9 |
| toolz | 0.11.1 | 3.6 3.7 3.8 3.9 |
| toposort | 1.6 | 3.6 3.7 3.8 3.9 |
| torch | 1.7.0 | 3.7 3.8 |
| torch | 1.9.0 | 3.7 3.8 3.9 |
| torchaudio | 0.9.0 | 3.7 3.8 3.9 |
| torchmetrics | 0.5.1 | 3.7 3.8 3.9 |
| torchtext | 0.10.0 | 3.7 3.8 3.9 |
| torchvision | 0.10.0 | 3.7 3.8 3.9 |
| torchvision | 0.8.1 | 3.7 3.8 |
| tornado | 6.1 | 3.6 3.7 3.8 3.9 |
| torthrift | 0.2.4 | 3.6 3.7 3.8 3.9 |
| towncrier | 21.3.0 | 3.6 3.7 3.8 3.9 |
| tox | 3.24.3 | 3.6 3.7 3.8 3.9 |
| tqdm | 4.62.2 | 3.6 3.7 3.8 3.9 |
| tracers | 21.8.6876 | 3.7 3.8 3.9 |
| traitlets | 4.3.3 | 3.6 |
| traitlets | 5.1.0 | 3.7 3.8 3.9 |
| trans | 2.1.0 | 3.6 3.7 3.8 3.9 |
| transaction | 3.0.1 | 3.6 3.7 3.8 3.9 |
| transformers | 4.10.0 | 3.6 3.7 3.8 3.9 |
| transformers | 4.10.2 | 3.7 3.8 3.9 |
| transitions | 0.8.9 | 3.6 3.7 3.8 3.9 |
| translationstring | 1.4 | 3.6 3.7 3.8 3.9 |
| tree-sitter | 0.19.0 | 3.6 3.8 3.9 |
| trimesh | 3.9.30 | 3.7 3.8 3.9 |
| trio | 0.19.0 | 3.6 3.7 3.8 3.9 |
| troposphere | 3.0.3 | 3.7 3.8 3.9 |
| trytond | 6.0.6 | 3.6 3.7 3.8 3.9 |
| trytond | 6.0.7 | 3.6 3.7 3.8 3.9 |
| trytond-account | 6.0.3 | 3.6 3.7 3.8 3.9 |
| trytond-company | 6.0.4 | 3.6 3.7 3.8 3.9 |
| trytond-country | 6.0.1 | 3.6 3.7 3.8 3.9 |
| trytond-currency | 6.0.1 | 3.6 3.7 3.8 3.9 |
| trytond-party | 6.0.2 | 3.6 3.7 3.8 3.9 |
| tskit | 0.3.7 | 3.7 3.8 3.9 |
| tweepy | 3.10.0 | 3.6 3.7 3.8 3.9 |
| twilio | 6.63.1 | 3.6 3.7 3.8 3.9 |
| twine | 3.4.2 | 3.6 3.7 3.8 3.9 |
| twisted | 21.2.0 | 3.6 |
| twisted | 21.7.0 | 3.7 3.8 3.9 |
| txaio | 21.2.1 | 3.6 3.7 3.8 3.9 |
| typed-ast | 1.4.3 | 3.6 3.7 3.8 3.9 |
| typeguard | 2.12.1 | 3.6 3.7 3.8 3.9 |
| typer | 0.3.2 | 3.6 3.7 3.8 3.9 |
| typer | 0.4.0 | 3.6 3.7 3.8 3.9 |
| types-pyyaml | 5.4.10 | 3.6 3.7 3.8 3.9 |
| types-requests | 2.25.6 | 3.6 3.7 3.8 3.9 |
| typing | 3.7.4.3 | 3.6 |
| typing-compat | 0.1.0 | 3.6 3.7 3.8 3.9 |
| typing-extensions | 3.10.0.1 | 3.6 3.7 3.8 3.9 |
| typing-extensions | 3.10.0.2 | 3.6 3.7 3.8 3.9 |
| typing-extensions | 3.7.4.3 | 3.6 3.7 3.8 3.9 |
| typing-inspect | 0.7.1 | 3.6 3.7 3.8 3.9 |
| tzdata | 2021.1 | 3.6 3.7 3.8 3.9 |
| tzlocal | 2.1 | 3.6 3.7 3.8 3.9 |
| tzlocal | 3.0 | 3.6 3.7 3.8 3.9 |
| ujson | 4.1.0 | 3.6 3.7 3.8 3.9 |
| unicodecsv | 0.14.1 | 3.6 3.7 3.8 3.9 |
| unidecode | 1.1.2 | 3.6 3.7 3.8 3.9 |
| unidecode | 1.3.1 | 3.6 3.7 3.8 3.9 |
| unidecode | 1.3.2 | 3.6 3.7 3.8 3.9 |
| unipath | 1.1 | 3.6 3.7 3.8 3.9 |
| uritemplate | 3.0.1 | 3.6 3.7 3.8 3.9 |
| urllib3 | 1.25.11 | 3.6 3.7 3.8 3.9 |
| urllib3 | 1.26.6 | 3.6 3.7 3.8 3.9 |
| urllib3 | 1.26.7 | 3.6 3.7 3.8 3.9 |
| url-normalize | 1.4.3 | 3.7 3.8 3.9 |
| urwid | 2.1.2 | 3.6 3.7 3.8 3.9 |
| uuid | 1.30 | 3.6 3.7 3.8 3.9 |
| uvicorn | 0.15.0 | 3.6 3.7 3.8 3.9 |
| uvloop | 0.16.0 | 3.7 3.8 3.9 |
| validate-docbr | 1.8.2 | 3.6 3.7 3.8 3.9 |
| validate-email | 1.3 | 3.6 3.7 3.8 3.9 |
| validators | 0.18.2 | 3.6 3.7 3.8 3.9 |
| varint | 1.0.2 | 3.8 3.9 |
| vcrpy | 4.1.1 | 3.6 3.7 3.8 3.9 |
| venusian | 3.0.0 | 3.6 3.7 3.8 3.9 |
| versioneer | 0.20 | 3.6 3.7 3.8 3.9 |
| vine | 1.3.0 | 3.6 3.7 3.8 3.9 |
| vine | 5.0.0 | 3.6 3.7 3.8 3.9 |
| virtualenv | 20.7.2 | 3.6 3.7 3.8 3.9 |
| virtualenv | 20.8.0 | 3.6 3.7 3.8 3.9 |
| virtualenv-clone | 0.5.7 | 3.6 3.7 3.8 3.9 |
| visitor | 0.1.3 | 3.6 3.7 3.8 3.9 |
| vobject | 0.9.6.1 | 3.6 3.7 3.8 3.9 |
| voluptuous | 0.12.1 | 3.6 3.7 3.8 3.9 |
| vsts | 0.1.25 | 3.6 3.7 3.8 3.9 |
| w3lib | 1.22.0 | 3.6 3.7 3.8 3.9 |
| wagtail | 2.14.1 | 3.6 3.7 3.8 3.9 |
| waitress | 2.0.0 | 3.6 3.7 3.8 3.9 |
| wand | 0.6.7 | 3.6 3.7 3.8 3.9 |
| warlock | 1.3.3 | 3.6 3.7 3.8 3.9 |
| wasabi | 0.8.2 | 3.6 3.7 3.8 3.9 |
| watchdog | 2.1.5 | 3.6 3.7 3.8 3.9 |
| watchgod | 0.7 | 3.6 3.7 3.8 3.9 |
| watchtower | 1.0.6 | 3.6 3.7 3.8 3.9 |
| wcwidth | 0.2.5 | 3.6 3.7 3.8 3.9 |
| weasyprint | 53.3 | 3.6 3.7 3.8 3.9 |
| webargs | 5.5.3 | 3.6 3.7 3.8 3.9 |
| webassets | 2.0 | 3.6 3.7 3.8 3.9 |
| webcolors | 1.11.1 | 3.6 3.7 3.8 3.9 |
| webdriver-manager | 3.4.2 | 3.6 3.7 3.8 3.9 |
| webencodings | 0.5.1 | 3.6 3.7 3.8 3.9 |
| webob | 1.8.7 | 3.6 3.7 3.8 3.9 |
| websocket-client | 0.56.0 | 3.6 3.7 3.8 3.9 |
| websocket-client | 0.59.0 | 3.6 3.7 3.8 3.9 |
| websocket-client | 1.2.1 | 3.6 3.7 3.8 3.9 |
| websockets | 10.0 | 3.7 3.8 3.9 |
| websockets | 8.0.2 | 3.6 |
| websockets | 9.1 | 3.7 3.8 3.9 |
| webstack-django-sorting | 2.0.2 | 3.6 3.7 3.8 3.9 |
| webtest | 3.0.0 | 3.6 3.7 3.8 3.9 |
| werkzeug | 1.0.1 | 3.6 3.7 3.8 3.9 |
| werkzeug | 2.0.1 | 3.6 3.7 3.8 3.9 |
| wget | 3.2 | 3.6 3.7 3.8 3.9 |
| wheel | 0.37.0 | 3.6 3.7 3.8 3.9 |
| whitenoise | 5.3.0 | 3.6 3.7 3.8 3.9 |
| whoosh | 2.7.4 | 3.6 3.7 3.8 3.9 |
| wikipedia | 1.4.0 | 3.6 3.7 3.8 3.9 |
| willow | 1.4 | 3.6 3.7 3.8 3.9 |
| win32-setctime | 1.0.3 | 3.6 3.7 3.8 3.9 |
| win-inet-pton | 1.1.0 | 3.6 3.7 3.8 3.9 |
| wmctrl | 0.4 | 3.6 3.7 3.8 3.9 |
| wordcloud | 1.8.1 | 3.6 3.7 3.8 3.9 |
| wordsegment | 1.3.1 | 3.6 3.7 3.8 3.9 |
| wrapt | 1.12.1 | 3.6 3.7 3.8 3.9 |
| wrapt | 1.13.1 | 3.6 3.7 3.8 3.9 |
| wrapt | 1.13.2 | 3.6 3.7 3.8 3.9 |
| ws4py | 0.5.1 | 3.8 3.9 |
| wsgiproxy2 | 0.5.1 | 3.6 3.7 3.8 3.9 |
| wslink | 1.0.7 | 3.6 3.7 3.8 3.9 |
| wtforms | 2.3.3 | 3.6 3.7 3.8 3.9 |
| x256 | 0.0.3 | 3.6 3.7 3.8 3.9 |
| xarray | 0.19.0 | 3.7 3.8 3.9 |
| xdg | 5.1.1 | 3.6 3.7 3.8 3.9 |
| xgboost | 1.4.2 | 3.6 3.7 3.8 3.9 |
| xlrd | 1.2.0 | 3.7 3.8 3.9 |
| xlrd | 2.0.1 | 3.6 3.7 3.8 3.9 |
| xlsxwriter | 1.4.5 | 3.6 3.7 3.8 3.9 |
| xlsxwriter | 3.0.1 | 3.6 3.7 3.8 3.9 |
| xlwt | 1.3.0 | 3.6 3.7 3.8 3.9 |
| xmlrpc2 | 0.3.1 | 3.6 3.7 3.8 3.9 |
| xmltodict | 0.12.0 | 3.6 3.7 3.8 3.9 |
| xxhash | 2.0.2 | 3.6 3.7 3.8 3.9 |
| yamllint | 1.26.3 | 3.6 3.7 3.8 3.9 |
| yapf | 0.31.0 | 3.6 3.7 3.8 3.9 |
| yarl | 1.6.3 | 3.6 3.7 3.8 3.9 |
| yaspin | 1.5.0 | 3.6 |
| yaspin | 2.1.0 | 3.7 3.8 3.9 |
| yfinance | 0.1.63 | 3.6 3.7 3.8 3.9 |
| youtube-dl | 2021.6.6 | 3.6 3.7 3.8 3.9 |
| z3c-autoinclude | 0.4.1 | 3.6 3.7 3.8 3.9 |
| z3c-caching | 2.2 | 3.6 3.7 3.8 3.9 |
| z3c-form | 4.2 | 3.6 3.7 3.8 3.9 |
| z3c-formwidget-query | 0.17 | 3.6 3.7 3.8 3.9 |
| z3c-jbot | 1.1.1 | 3.6 3.7 3.8 3.9 |
| z3c-objpath | 1.2 | 3.6 3.7 3.8 3.9 |
| z3c-pt | 3.3.0 | 3.6 3.7 3.8 3.9 |
| z3c-relationfield | 0.9.0 | 3.6 3.7 3.8 3.9 |
| z3c-zcmlhook | 1.1 | 3.6 3.7 3.8 3.9 |
| zc-buildout | 2.13.4 | 3.6 3.7 3.8 3.9 |
| zc-lockfile | 2.0 | 3.6 3.7 3.8 3.9 |
| zconfig | 3.6.0 | 3.6 3.7 3.8 3.9 |
| zc-relation | 1.1.post2 | 3.6 3.7 3.8 3.9 |
| zdaemon | 4.3 | 3.6 3.7 3.8 3.9 |
| zeep | 4.1.0 | 3.6 3.7 3.8 3.9 |
| zenpy | 2.0.24 | 3.6 3.7 3.8 3.9 |
| zeo | 5.2.3 | 3.6 3.7 3.8 3.9 |
| zexceptions | 4.1 | 3.6 3.7 3.8 3.9 |
| zict | 2.0.0 | 3.7 3.8 3.9 |
| zipp | 3.5.0 | 3.6 3.7 3.8 3.9 |
| zipp | 3.6.0 | 3.6 3.7 3.8 3.9 |
| zmq | 0.0.0 | 3.6 3.7 3.8 3.9 |
| zodb | 5.6.0 | 3.6 3.7 3.8 3.9 |
| zodb3 | 3.11.0 | 3.6 3.7 3.8 3.9 |
| zodbpickle | 2.0.0 | 3.6 3.7 3.8 3.9 |
| zodbpickle | 2.2.0 | 3.6 3.7 3.8 3.9 |
| zope | 5.3 | 3.6 3.7 3.8 3.9 |
| zope2 | 4.0 | 3.6 3.7 3.8 3.9 |
| zope-annotation | 4.7.0 | 3.6 3.7 3.8 3.9 |
| zope-app-locales | 4.1 | 3.6 3.7 3.8 3.9 |
| zope-browser | 2.3 | 3.6 3.7 3.8 3.9 |
| zope-browsermenu | 4.4 | 3.6 3.7 3.8 3.9 |
| zope-browserpage | 4.4.0 | 3.6 3.7 3.8 3.9 |
| zope-browserresource | 4.4 | 3.6 3.7 3.8 3.9 |
| zope-cachedescriptors | 4.3.1 | 3.6 3.7 3.8 3.9 |
| zope-component | 5.0.1 | 3.6 3.7 3.8 3.9 |
| zope-componentvocabulary | 2.2.0 | 3.6 3.7 3.8 3.9 |
| zope-configuration | 4.4.0 | 3.6 3.7 3.8 3.9 |
| zope-container | 4.4.0 | 3.6 3.7 3.8 3.9 |
| zope-contentprovider | 4.2.1 | 3.6 3.7 3.8 3.9 |
| zope-contenttype | 4.5.0 | 3.6 3.7 3.8 3.9 |
| zope-copy | 4.2 | 3.6 3.7 3.8 3.9 |
| zope-datetime | 4.3.0 | 3.6 3.7 3.8 3.9 |
| zope-deferredimport | 4.3.1 | 3.6 3.7 3.8 3.9 |
| zope-deprecation | 4.4.0 | 3.6 3.7 3.8 3.9 |
| zope-dottedname | 4.3 | 3.6 3.7 3.8 3.9 |
| zope-event | 4.5.0 | 3.6 3.7 3.8 3.9 |
| zope-exceptions | 4.4 | 3.6 3.7 3.8 3.9 |
| zope-filerepresentation | 5.0.0 | 3.6 3.7 3.8 3.9 |
| zope-globalrequest | 1.5 | 3.6 3.7 3.8 3.9 |
| zope-hookable | 5.1.0 | 3.6 3.7 3.8 3.9 |
| zope-i18n | 4.8.0 | 3.6 3.7 3.8 3.9 |
| zope-i18nmessageid | 5.0.1 | 3.6 3.7 3.8 3.9 |
| zope-interface | 5.4.0 | 3.6 3.7 3.8 3.9 |
| zope-intid | 4.4.0 | 3.6 3.7 3.8 3.9 |
| zope-keyreference | 4.2.0 | 3.6 3.7 3.8 3.9 |
| zope-lifecycleevent | 4.3 | 3.6 3.7 3.8 3.9 |
| zope-location | 4.2 | 3.6 3.7 3.8 3.9 |
| zope-pagetemplate | 4.5.0 | 3.6 3.7 3.8 3.9 |
| zope-processlifetime | 2.3.0 | 3.6 3.7 3.8 3.9 |
| zope-proxy | 4.4.0 | 3.6 3.7 3.8 3.9 |
| zope-ptresource | 4.2.0 | 3.6 3.7 3.8 3.9 |
| zope-publisher | 6.0.2 | 3.6 3.7 3.8 3.9 |
| zope-ramcache | 2.3 | 3.6 3.7 3.8 3.9 |
| zope-schema | 6.1.0 | 3.6 3.7 3.8 3.9 |
| zope-security | 5.1.1 | 3.6 3.7 3.8 3.9 |
| zope-sendmail | 5.2 | 3.6 3.7 3.8 3.9 |
| zope-sequencesort | 4.1.2 | 3.6 3.7 3.8 3.9 |
| zope-site | 4.5.0 | 3.6 3.7 3.8 3.9 |
| zope-size | 4.3 | 3.6 3.7 3.8 3.9 |
| zope-sqlalchemy | 1.6 | 3.6 3.7 3.8 3.9 |
| zope-structuredtext | 4.3 | 3.6 3.7 3.8 3.9 |
| zope-tal | 4.5 | 3.6 3.7 3.8 3.9 |
| zope-tales | 5.1 | 3.6 3.7 3.8 3.9 |
| zope-testbrowser | 5.5.1 | 3.6 3.7 3.8 3.9 |
| zope-testing | 4.9 | 3.6 3.7 3.8 3.9 |
| zope-testrunner | 5.3.0 | 3.6 3.7 3.8 3.9 |
| zope-traversing | 4.4.1 | 3.6 3.7 3.8 3.9 |
| zope-viewlet | 4.2.1 | 3.6 3.7 3.8 3.9 |
| zopfli | 0.1.8 | 3.6 3.7 3.8 3.9 |
| zstandard | 0.15.2 | 3.6 3.7 3.8 3.9 |

# Applications vs Libraries

On Python, projects can offer two types of components:

- **Applications**: Binaries that you can run from the command line:

  - [AWS CLI](https://pypi.org/project/awscli/): `$ aws`
  - [Bandit](https://pypi.org/project/bandit/): `$ bandit`
  - ...

- **Libraries**: Packages and modules that you can import in your Python projects:

  - [Boto3](https://pypi.org/project/boto3/): `>>> import boto3`
  - [Django](https://pypi.org/project/django/): `>>> from django import *`
  - ...

- **Both**: They work either as an Application and/or as a Library:

  - [PyTest](https://pypi.org/project/pytest/): `$ pytest`, or `>>> import pytest`
  - ...

# Using with Nix stable

## Installing Applications

Simply run the following magic from a terminal.

```bash
$ nix-env -iA 'apps."<project>"."<version>"' -f https://github.com/kamadorueda/python-on-nix/tarball/main
```

For example:

- ```bash
  $ nix-env -iA 'apps."awscli"."1.20.31"' -f https://github.com/kamadorueda/python-on-nix/tarball/main
  ```
- ```bash
  $ nix-env -iA 'apps."pytest"."latest"' -f https://github.com/kamadorueda/python-on-nix/tarball/main
  ```

After the process have completed,
you will be able to use the project's binaries:

```bash

$ aws --version
  aws-cli/1.20.31 Python/3.9.6 Linux/5.10.62 botocore/1.21.31
$ pytest --version
  pytest 6.2.5
```

## Creating Python environments with Applications and Libraries

First,
you need to import `Python on Nix`
into your project.

For example:

```nix
# /path/to/my/env.nix

let
  pythonOnNix = import (builtins.fetchGit {
    # Use `main` branch or a commit from this list:
    # https://github.com/kamadorueda/python-on-nix/commits/main
    ref = "main";
    url = "https://github.com/kamadorueda/python-on-nix";
  });
in
# Keep reading for more information
```

This repository offers you
the following functions.
Please pick the Python version of your choice:
- `python36Env`: Python 3.6
- `python37Env`: Python 3.7
- `python38Env`: Python 3.8
- `python39Env`: Python 3.9
- `python310Env`: Python 3.10

For example:

```nix
# /path/to/my/env.nix (continuation)

pythonOnNix.python39Env {
  name = "example";
  projects = {
    awscli = "1.20.31";
    numpy = "latest";
    requests = "latest";
    torch = "1.9.0";
  };
};
```

The output of this function
contains a setup script
that you can `source`:

```bash
# Build your environment
$ nix-build /path/to/my/env.nix

# Source it's output
$ source ./result/setup
```

After doing this,
the specified dependencies will be available in your shell ! :rocket:

Also, you'll be able to use the applications and libraries provided
by the projects in the environment:

```bash
$ python --version
  Python 3.9.6
$ aws --version
  aws-cli/1.20.31 Python/3.9.6 Linux/5.10.57 botocore/1.21.31
$ python -c 'import numpy; print(numpy.__version__)'
  1.21.2
$ python -c 'import requests; print(requests.__version__)'
  2.26.0
$ python -c 'import torch; print(torch.__version__)'
  1.9.0+cu102
```

### Compatibility with Nixpkgs

You can use `Python On Nix` and `Nixpkgs` together.

For example:

```nix
# /path/to/my/expression.nix

let
  # import projects as explained in previous sections
  nixpkgs = import { ... };
  pythonOnNix = import { ... };

  # Create a Python on Nix environment as explained in previous sections
  env = pythonOnNix.python39Env {
    name = "example";
    projects = {
      awscli = "1.20.31";
      numpy = "latest";
      requests = "latest";
      torch = "1.9.0";
    };
  };
in
nixpkgs.stdenv.mkDerivation {
  buildInputs = [ env ];
  builder = builtins.toFile "builder.sh" ''
    source $stdenv/setup

    set -x

    python --version
    aws --version
    python -c 'import numpy; print(numpy.__version__)'
    python -c 'import requests; print(requests.__version__)'
    python -c 'import torch; print(torch.__version__)'

    touch $out

    set +x
  '';
  name = "example";
}
```

Now just `$ nix-build /path/to/my/expression.nix` ! :rocket:

```bash
these derivations will be built:
  /nix/store/4l51x7983ggxc8z5fmb5wzhvvx8kvn01-example.drv

building '/nix/store/4l51x7983ggxc8z5fmb5wzhvvx8kvn01-example.drv'...

+ python --version
  Python 3.9.6
+ aws --version
  aws-cli/1.20.31 Python/3.9.6 Linux/5.10.57 botocore/1.21.31
+ python -c 'import numpy; print(numpy.__version__)'
  1.21.2
+ python -c 'import requests; print(requests.__version__)'
  2.26.0
+ python -c 'import torch; print(torch.__version__)'
  1.9.0+cu102
+ touch /nix/store/9cckx5zpbiakx507g253fv08hykf8msv-example
```
# Using with Nix unstable (Nix Flakes)

This project is also offered as a Nix Flake.

:warning: This section is for advanced Nix users.
You can skip its content
as Nix Flakes are currently
an **unstable** release of Nix.

## List of available projects

```bash
$ nix flake show github:kamadorueda/python-on-nix
```

## Trying out Applications without installing them

- `$ nix shell 'github:kamadorueda/python-on-nix#"awscli-1.20.31-latest-bin"'`
- `$ nix shell 'github:kamadorueda/python-on-nix#"pytest-latest-python37-bin"'`

## Installing Applications

- `$ nix profile install 'github:kamadorueda/python-on-nix#"awscli-1.20.31-latest-bin"'`
- `$ nix profile install 'github:kamadorueda/python-on-nix#"pytest-latest-python37-bin"'`

## Creating Python environments with Applications and Libraries

```nix
# /path/to/my/project/flake.nix
{
  inputs = {
    # Import projects
    nixpkgs.url = "github:nixos/nixpkgs";
    pythonOnNix.url = "github:kamadorueda/python-on-nix";
  };
  outputs = { nixpkgs, pythonOnNix, ... }: {
    packages.x86_64-linux = {

      example = pythonOnNix.lib.python39Env {
        name = "example";
        projects = {
          awscli = "1.20.31";
          numpy = "latest";
          requests = "latest";
          torch = "1.9.0";
        };
      };

    };
  };
}
```

The output of this function
contains a setup script
that you can `source`:

```bash
# Build your environment
$ nix build '.#example'

# Source it's output
$ source ./result/setup
```

After doing this,
the specified dependencies will be available in your shell ! :rocket:

Also, you'll be able to use the applications and libraries provided
by the projects in the environment:

```bash
$ python --version
  Python 3.9.6
$ aws --version
  aws-cli/1.20.31 Python/3.9.6 Linux/5.10.57 botocore/1.21.31
$ python -c 'import numpy; print(numpy.__version__)'
  1.21.2
$ python -c 'import requests; print(requests.__version__)'
  2.26.0
$ python -c 'import torch; print(torch.__version__)'
  1.9.0+cu102
```

## Compatibility with Nixpkgs

You can use `Python on Nix` and `Nixpkgs` together.

For example:

```nix
# /path/to/my/project/flake.nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    pythonOnNix.url = "github:kamadorueda/python-on-nix";
  };
  outputs = { nixpkgs, pythonOnNix, self, ... }: {
    packages.x86_64-linux = {

      example = pythonOnNix.lib.python39Env {
        name = "example";
        projects = {
          awscli = "1.20.31";
          numpy = "latest";
          requests = "latest";
          torch = "1.9.0";
        };
      };

      something = nixpkgs.legacyPackages.x86_64-linux.stdenv.mkDerivation {
        buildInputs = [ self.packages.x86_64-linux.example ];
        builder = builtins.toFile "builder.sh" ''
          source $stdenv/setup

          set -x

          python --version
          aws --version
          python -c 'import numpy; print(numpy.__version__)'
          python -c 'import requests; print(requests.__version__)'
          python -c 'import torch; print(torch.__version__)'

          touch $out

          set +x
        '';
        name = "example";
      };
    };
  };
}
```

Now just `$ nix -L build .#something` ! :rocket:

```bash
+ python --version
  Python 3.9.6
+ aws --version
  aws-cli/1.20.31 Python/3.9.6 Linux/5.10.62 botocore/1.21.31
+ python -c 'import numpy; print(numpy.__version__)'
  1.21.2
+ python -c 'import requests; print(requests.__version__)'
  2.26.0
+ python -c 'import torch; print(torch.__version__)'
  1.9.0+cu102

+ touch /nix/store/dcccmxjllgwb9c9j6irp68f1qp4ssxyg-example
```

# Contributing

Anything you can think of will be appreciated!

Also a few dollars are always welcome :grin:

- https://www.patreon.com/kamadorueda

# License

Code on this branch is dedicated to the public domain
via [The Unlicense](https://unlicense.org/) license.

In other words you can do anything you want with it.

Please enjoy! :rocket:

---

[NIX]: https://nixos.org/
[PROJECTS]: #list-of-available-projects
[PYPI]: https://pypi.org/
[PYTHON]: https://www.python.org/
[PYTHON_RELEASES]: https://www.python.org/downloads/
[PYTHON_WHEELS]: https://pythonwheels.com/
