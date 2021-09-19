# Python on Nix

Extensive collection
of [Python][PYTHON] projects
from the [Python Packaging Index][PYPI].
That can be used with the [Nix][NIX] package manager.

- Scope:
  - :heavy_check_mark:
    All [active Python releases][PYTHON_RELEASES] (`3.6`, `3.7`, `3.8`, `3.9`)
  - :heavy_check_mark: 1000+ [projects](./projects) already packaged
- Quality:
  - :heavy_check_mark: It is 100% Nix, with love :heart:
  - :heavy_check_mark: Data integrity checksums are used everywhere
  - :heavy_check_mark: We test projects before you use them
- Platforms:
  - :heavy_check_mark: Linux x86-64
  - :construction: MacOS x86-64
- Performance:
  - :heavy_check_mark: We **always** pick [Wheels][PYTHON_WHEELS]
  - :heavy_check_mark: A highly granular cache

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
# Contents

- [Why](#why)
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

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Why

To make using Nix on Python projects
as simple as possible :heavy_check_mark:

Just copy and paste the examples,
pick the projects of your choice,
and use!
:nerd_face:

# List of available projects

Additionally to the versions below,
there is a meta-version called `latest`
which points to the latest version of the project.

| Project | Version |
| ------- | :-----: |
| about-time | 3.1.1 |
| absl-py | 0.12.0 |
| absl-py | 0.13.0 |
| accesscontrol | 5.2 |
| access-points | 0.4.66 |
| acme | 1.19.0 |
| acquisition | 4.9 |
| adafruit-blinka | 6.13.0 |
| adafruit-circuitpython-busdevice | 5.0.6 |
| adafruit-platformdetect | 3.15.3 |
| adafruit-pureio | 1.1.9 |
| adal | 1.2.7 |
| addict | 2.4.0 |
| aenum | 3.1.0 |
| affine | 2.3.0 |
| aioboto3 | 8.0.3 |
| aioboto3 | 9.2.0 |
| aiobotocore | 1.0.4 |
| aiobotocore | 1.3.3 |
| aiobotocore | 1.4.1 |
| aiocontextvars | 0.2.2 |
| aiodataloader | 0.2.0 |
| aiodns | 3.0.0 |
| aioextensions | 21.7.2261349 |
| aiofiles | 0.7.0 |
| aiogqlc | 1.0.5 |
| aiogqlc | 2.2.0 |
| aiohttp | 3.7.4.post0 |
| aiohttp-apispec | 2.2.1 |
| aiohttp-cors | 0.7.0 |
| aioitertools | 0.8.0 |
| aiomultiprocess | 0.9.0 |
| aiomysql | 0.0.21 |
| aio-pika | 6.8.0 |
| aioredis | 2.0.0 |
| aiormq | 3.3.1 |
| aiosqlite | 0.17.0 |
| alabaster | 0.7.12 |
| albumentations | 1.0.3 |
| alembic | 1.4.1 |
| alembic | 1.6.5 |
| alembic | 1.7.1 |
| alembic | 1.7.3 |
| alibabacloud-credentials | 0.1.4 |
| alibabacloud-credentials-py2 | 0.0.3 |
| alibabacloud-endpoint-util | 0.0.3 |
| alibabacloud-endpoint-util-py2 | 0.0.2 |
| alibabacloud-openapi-util | 0.1.5 |
| alibabacloud-tea | 0.2.8 |
| alibabacloud-tea-openapi | 0.2.7 |
| alibabacloud-tea-openapi-py2 | 0.0.6 |
| alibabacloud-tea-py2 | 0.0.3 |
| alibabacloud-tea-util | 0.3.5 |
| alibabacloud-tea-util-py2 | 0.0.5 |
| alive-progress | 2.0.0 |
| aliyun-python-sdk-core | 2.13.35 |
| alphalens | 0.4.0 |
| altair | 4.1.0 |
| altgraph | 0.17.2 |
| amazon-dax-client | 2.0.0 |
| amqp | 2.6.1 |
| amqp | 5.0.6 |
| aniso8601 | 7.0.0 |
| aniso8601 | 9.0.1 |
| anndata | 0.7.6 |
| ansible | 4.5.0 |
| ansible-core | 2.11.4 |
| ansicon | 1.89.0 |
| ansiwrap | 0.8.4 |
| antlr4-python3-runtime | 4.7.2 |
| antlr4-python3-runtime | 4.8 |
| antlr4-python3-runtime | 4.9.2 |
| anyascii | 0.3.0 |
| anyio | 3.3.0 |
| anyio | 3.3.1 |
| anyjson | 0.3.3 |
| anytree | 2.8.0 |
| apache-airflow-providers-http | 2.0.1 |
| apispec | 3.3.2 |
| apispec | 5.1.0 |
| appdirs | 1.4.4 |
| appium-python-client | 1.2.0 |
| applicationinsights | 0.11.10 |
| appnope | 0.1.2 |
| apscheduler | 3.6.3 |
| apscheduler | 3.7.0 |
| argcomplete | 1.12.3 |
| argh | 0.26.2 |
| argon2-cffi | 21.1.0 |
| argparse | 1.4.0 |
| args | 0.1.0 |
| ariadne | 0.13.0 |
| arrow | 1.1.1 |
| arviz | 0.11.2 |
| asciitree | 0.3.3 |
| ase | 3.22.0 |
| asgi-csrf | 0.9 |
| asgiref | 3.4.1 |
| asn1crypto | 1.4.0 |
| asteval | 0.9.25 |
| astor | 0.8.1 |
| astroid | 2.7.3 |
| astroid | 2.8.0 |
| astropy | 4.1 |
| astropy | 4.3.1 |
| astroquery | 0.4.3 |
| astunparse | 1.6.3 |
| async-generator | 1.10 |
| asyncio | 3.4.3 |
| async-lru | 1.0.2 |
| asyncpg | 0.24.0 |
| asyncssh | 2.7.2 |
| asynctest | 0.13.0 |
| async-timeout | 3.0.1 |
| atomicwrites | 1.4.0 |
| attrdict | 2.0.1 |
| attrs | 20.3.0 |
| attrs | 21.2.0 |
| audioread | 2.1.9 |
| authencoding | 4.3 |
| authlib | 0.15.4 |
| autobahn | 21.2.1 |
| autobahn | 21.3.1 |
| autoflake | 1.4 |
| autograd | 1.3 |
| automat | 20.2.0 |
| autopage | 0.4.0 |
| autopep8 | 1.5.7 |
| aws-cdk-assets | 1.123.0 |
| aws-cdk-aws-applicationautoscaling | 1.123.0 |
| aws-cdk-aws-autoscaling-common | 1.123.0 |
| aws-cdk-aws-cloudwatch | 1.123.0 |
| aws-cdk-aws-codeguruprofiler | 1.123.0 |
| aws-cdk-aws-codestarnotifications | 1.123.0 |
| aws-cdk-aws-ec2 | 1.123.0 |
| aws-cdk-aws-events | 1.123.0 |
| aws-cdk-aws-iam | 1.123.0 |
| aws-cdk-aws-kms | 1.123.0 |
| aws-cdk-aws-lambda | 1.123.0 |
| aws-cdk-aws-logs | 1.123.0 |
| aws-cdk-aws-s3 | 1.123.0 |
| aws-cdk-aws-s3-assets | 1.123.0 |
| aws-cdk-aws-signer | 1.123.0 |
| aws-cdk-aws-sns | 1.123.0 |
| aws-cdk-aws-sqs | 1.123.0 |
| aws-cdk-aws-ssm | 1.123.0 |
| aws-cdk-cdk | 0.36.1 |
| aws-cdk-cloud-assembly-schema | 1.122.0 |
| aws-cdk-cloud-assembly-schema | 1.123.0 |
| aws-cdk-core | 1.123.0 |
| aws-cdk-custom-resources | 1.123.0 |
| aws-cdk-cx-api | 1.123.0 |
| aws-cdk-region-info | 1.123.0 |
| awscli | 1.20.31 |
| aws-lambda-builders | 1.6.0 |
| aws-okta-processor | 1.7.0 |
| aws-sam-translator | 1.38.0 |
| aws-xray-sdk | 2.8.0 |
| azure-cli-command-modules-nspkg | 2.0.3 |
| azure-cli-core | 2.28.1 |
| azure-cli-nspkg | 3.0.4 |
| azure-cli-telemetry | 1.0.6 |
| azure-common | 1.1.27 |
| azure-core | 1.18.0 |
| azure-graphrbac | 0.61.1 |
| azure-identity | 1.6.1 |
| azure-mgmt-authorization | 0.61.0 |
| azure-mgmt-core | 1.2.2 |
| azure-mgmt-core | 1.3.0 |
| azure-mgmt-nspkg | 3.0.2 |
| azure-mgmt-resource | 20.0.0 |
| azureml-core | 1.34.0 |
| azure-nspkg | 3.0.2 |
| azure-storage | 0.37.0 |
| azure-storage-blob | 12.8.1 |
| babel | 2.9.1 |
| backcall | 0.2.0 |
| backoff | 1.11.1 |
| backoff | 1.8.0 |
| backports-csv | 1.0.7 |
| backports-entry-points-selectable | 1.1.0 |
| backports-functools-lru-cache | 1.6.4 |
| backports-zoneinfo | 0.2.1 |
| bandit | 1.7.0 |
| base58 | 2.1.0 |
| bcrypt | 3.2.0 |
| beautifulsoup | 3.2.2 |
| beautifulsoup4 | 4.10.0 |
| beautifulsoup4 | 4.9.3 |
| behave | 1.2.6 |
| bibtexparser | 1.2.0 |
| bidict | 0.21.3 |
| billiard | 3.6.4.0 |
| binaryornot | 0.4.4 |
| biopython | 1.79 |
| bitarray | 1.2.2 |
| bitstring | 3.1.9 |
| black | 20.8b1 |
| black | 21.8b0 |
| black | 21.9b0 |
| bleach | 4.1.0 |
| blessed | 1.18.1 |
| blessings | 1.7 |
| blinker | 1.4 |
| blis | 0.7.4 |
| bluemix-service-discovery | 0.0.1 |
| bokeh | 2.3.3 |
| bokeh | 2.4.0 |
| boltons | 21.0.0 |
| bootstrap-admin | 0.4.4 |
| borg-localrole | 3.1.8 |
| boto | 2.49.0 |
| boto3 | 1.12.32 |
| boto3 | 1.17.106 |
| boto3 | 1.18.31 |
| boto3 | 1.18.32 |
| boto3 | 1.18.39 |
| boto3 | 1.18.44 |
| boto3-type-annotations | 0.3.1 |
| botocore | 1.15.32 |
| botocore | 1.15.49 |
| botocore | 1.20.106 |
| botocore | 1.20.112 |
| botocore | 1.21.31 |
| botocore | 1.21.32 |
| botocore | 1.21.36 |
| botocore | 1.21.39 |
| botocore | 1.21.44 |
| bottle | 0.12.19 |
| bottleneck | 1.3.2 |
| branca | 0.4.2 |
| brotli | 1.0.9 |
| brotlicffi | 1.0.9.2 |
| bs4 | 0.0.1 |
| bson | 0.5.10 |
| btrees | 4.9.2 |
| bugsnag | 4.1.0 |
| build | 0.6.1 |
| build | 0.7.0 |
| bump2version | 1.0.1 |
| bumpversion | 0.6.0 |
| cachecontrol | 0.12.6 |
| cached-property | 1.5.2 |
| cachetools | 4.2.2 |
| cachey | 0.2.1 |
| cachy | 0.3.0 |
| cairocffi | 1.2.0 |
| cairosvg | 2.5.2 |
| calmjs-parse | 1.2.5 |
| capacity | 1.3.14 |
| cartopy | 0.20.0 |
| cassandra-driver | 3.25.0 |
| catalogue | 2.0.6 |
| catboost | 0.26.1 |
| category-encoders | 2.2.2 |
| catkin-pkg | 0.4.23 |
| cattrs | 1.0.0 |
| cattrs | 1.1.0 |
| cattrs | 1.8.0 |
| cbor2 | 5.4.1 |
| cchardet | 2.1.7 |
| cdiff | 1.0 |
| celery | 5.1.2 |
| certbot | 1.19.0 |
| certifi | 2021.5.30 |
| certipy | 0.1.3 |
| cffi | 1.14.6 |
| cfgv | 3.3.1 |
| cfn-flip | 1.2.3 |
| cfn-lint | 0.53.0 |
| cftime | 1.5.0 |
| chameleon | 3.9.1 |
| channels | 3.0.4 |
| chardet | 3.0.4 |
| chardet | 4.0.0 |
| charset-normalizer | 2.0.4 |
| charset-normalizer | 2.0.6 |
| check-manifest | 0.46 |
| cheroot | 8.5.2 |
| cherrypy | 18.6.1 |
| ciso8601 | 2.2.0 |
| clang | 5.0 |
| cleo | 0.6.8 |
| cleo | 0.8.1 |
| cliar | 1.3.4 |
| click | 7.1.2 |
| click | 8.0.1 |
| clickclick | 20.10.2 |
| click-completion | 0.5.2 |
| click-default-group | 1.2.2 |
| click-didyoumean | 0.0.3 |
| click-help-colors | 0.9.1 |
| click-log | 0.3.2 |
| click-plugins | 1.1.1 |
| click-repl | 0.2.0 |
| click-spinner | 0.1.10 |
| cliff | 3.9.0 |
| cligj | 0.7.2 |
| clikit | 0.6.2 |
| clint | 0.5.1 |
| cloudmersive-virus-api-client | 3.0.5 |
| cloudpickle | 1.6.0 |
| cloudpickle | 2.0.0 |
| cmaes | 0.8.2 |
| cmake | 3.21.2 |
| cmd2 | 2.2.0 |
| codecov | 2.1.12 |
| collective-monkeypatcher | 1.2.1 |
| colorama | 0.4.3 |
| colorama | 0.4.4 |
| colorcet | 2.0.6 |
| colorclass | 2.2.0 |
| colored | 1.4.2 |
| coloredlogs | 14.0 |
| coloredlogs | 15.0.1 |
| colorlog | 6.4.1 |
| commonmark | 0.9.1 |
| comtypes | 1.1.10 |
| configargparse | 1.5.2 |
| configobj | 5.0.6 |
| configparser | 5.0.2 |
| confluent-kafka | 1.7.0 |
| confuse | 1.5.0 |
| connexion | 2.9.0 |
| constantly | 15.1.0 |
| construct | 2.10.67 |
| constructs | 10.0.5 |
| constructs | 3.3.147 |
| contextlib2 | 21.6.0 |
| contextvars | 2.4 |
| convertdate | 2.3.2 |
| cookiecutter | 1.7.3 |
| copyright | 1.0.1.0 |
| coreapi | 2.3.3 |
| coreschema | 0.0.4 |
| corner | 2.2.1 |
| countrycode | 0.2 |
| coverage | 5.5 |
| coverage-badge | 1.0.1 |
| coveralls | 3.2.0 |
| cramjam | 2.4.0 |
| crashtest | 0.3.1 |
| crayons | 0.4.0 |
| crcmod | 1.7 |
| croniter | 1.0.15 |
| cryptography | 3.3.2 |
| cryptography | 3.4.8 |
| cssmin | 0.2.0 |
| cssselect | 1.1.0 |
| cssselect2 | 0.4.1 |
| cssutils | 2.3.0 |
| cvxopt | 1.2.6 |
| cvxpy | 1.1.15 |
| cx-oracle | 8.2.1 |
| cycler | 0.10.0 |
| cymem | 2.0.5 |
| cython | 0.29.24 |
| cytoolz | 0.11.0 |
| dacite | 1.6.0 |
| dagster | 0.12.11 |
| daphne | 3.0.2 |
| dash | 2.0.0 |
| dash-bootstrap-components | 0.13.0 |
| dash-core-components | 2.0.0 |
| dash-html-components | 2.0.0 |
| dash-table | 5.0.0 |
| dask | 2021.9.0 |
| databricks-cli | 0.15.0 |
| dataclasses | 0.6 |
| dataclasses | 0.8 |
| dataclasses-json | 0.5.5 |
| datadog | 0.42.0 |
| datasets | 1.12.1 |
| datasette | 0.58.1 |
| dateparser | 1.0.0 |
| datetime | 4.3 |
| dateutils | 0.6.12 |
| dbutils | 2.0.2 |
| ddt | 1.4.2 |
| debtcollector | 2.3.0 |
| debugpy | 1.4.3 |
| decorator | 4.4.2 |
| decorator | 5.0.9 |
| decorator | 5.1.0 |
| deepdiff | 5.5.0 |
| deepmerge | 0.3.0 |
| defusedxml | 0.7.1 |
| delighted | 4.1.0 |
| demands | 5.0.0 |
| demes | 0.1.2 |
| deprecated | 1.2.12 |
| deprecated | 1.2.13 |
| deprecation | 2.1.0 |
| descartes | 1.1.0 |
| diazo | 1.4.1 |
| dictdiffer | 0.9.0 |
| dicttoxml | 1.7.4 |
| dill | 0.3.4 |
| discord | 1.7.3 |
| discord-py | 1.7.3 |
| discover | 0.4.0 |
| diskcache | 5.2.1 |
| distlib | 0.3.2 |
| distribute | 0.7.3 |
| distributed | 2021.9.0 |
| distro | 1.6.0 |
| django | 3.2.7 |
| django-allauth | 0.45.0 |
| django-anymail | 8.4 |
| django-appconf | 1.0.4 |
| django-cacheops | 6.0 |
| django-cache-url | 3.2.3 |
| django-classy-tags | 2.0.0 |
| django-cleanup | 5.2.0 |
| django-cms | 3.9.0 |
| djangocms-admin-style | 2.0.2 |
| django-compressor | 2.4.1 |
| django-cors-headers | 3.8.0 |
| django-crispy-forms | 1.12.0 |
| django-debug-toolbar | 3.2.2 |
| django-environ | 0.7.0 |
| django-extensions | 3.1.3 |
| django-filter | 2.4.0 |
| django-formtools | 2.3 |
| django-js-asset | 1.2.2 |
| django-modelcluster | 5.1 |
| django-model-utils | 4.1.1 |
| django-mptt | 0.13.3 |
| django-redis | 5.0.0 |
| djangorestframework | 3.12.4 |
| django-rest-passwordreset | 1.2.0 |
| django-taggit | 1.5.1 |
| django-treebeard | 4.5.1 |
| dj-database-url | 0.5.0 |
| dlib | 19.22.1 |
| dlx | 1.0.4 |
| dm-tree | 0.1.6 |
| dnslib | 0.9.16 |
| dnspython | 1.16.0 |
| dnspython | 2.1.0 |
| doc8 | 0.9.0 |
| docker | 5.0.0 |
| docker | 5.0.2 |
| docker-compose | 1.29.2 |
| dockerpty | 0.4.1 |
| docker-py | 1.10.6 |
| docker-pycreds | 0.4.0 |
| docker-services-cli | 0.3.1 |
| docopt | 0.6.2 |
| docplex | 2.22.213 |
| docstring-parser | 0.10 |
| documenttemplate | 4.0 |
| docutils | 0.15.2 |
| docutils | 0.16 |
| docutils | 0.17.1 |
| docxcompose | 1.3.3 |
| docxtpl | 0.12.0 |
| dodgy | 0.2.1 |
| dogpile-cache | 1.1.4 |
| dominate | 2.6.0 |
| dotmap | 1.3.24 |
| dparse | 0.5.1 |
| dpath | 2.0.2 |
| draftjs-exporter | 2.1.7 |
| dropbox | 11.19.0 |
| dtw | 1.4.0 |
| duckduckpy | 0.2 |
| dulwich | 0.20.25 |
| dynaconf | 3.1.5 |
| earthengine-api | 0.1.283 |
| easyprocess | 0.3 |
| ecdsa | 0.17.0 |
| ecos | 2.0.7.post1 |
| editdistance | 0.5.3 |
| einops | 0.3.2 |
| elasticsearch | 7.14.1 |
| elasticsearch-dsl | 7.4.0 |
| email-validator | 1.1.3 |
| emcee | 3.1.1 |
| emoji | 1.4.2 |
| empyrical | 0.5.5 |
| entrypoints | 0.3 |
| enum34 | 1.1.10 |
| enum-compat | 0.0.3 |
| environs | 9.3.3 |
| eth-abi | 2.1.1 |
| eth-account | 0.5.5 |
| eth-hash | 0.3.2 |
| eth-keyfile | 0.5.1 |
| eth-keys | 0.3.3 |
| eth-rlp | 0.2.1 |
| eth-typing | 2.2.2 |
| eth-utils | 1.10.0 |
| et-xmlfile | 1.1.0 |
| eventlet | 0.32.0 |
| exception | 0.1.0 |
| execnet | 1.9.0 |
| exponent-server-sdk | 2.0.0 |
| extensionclass | 4.5.1 |
| extras | 1.0.0 |
| fabric | 2.6.0 |
| factory-boy | 3.2.0 |
| faker | 8.12.1 |
| faker | 8.13.2 |
| fake-useragent | 0.1.11 |
| falcon | 3.0.1 |
| fancycompleter | 0.9.1 |
| fastai | 2.5.2 |
| fastapi | 0.68.1 |
| fastavro | 1.4.4 |
| fastcore | 1.3.26 |
| fastdownload | 0.0.5 |
| fastdtw | 0.3.4 |
| fasteners | 0.16.3 |
| fastjsonschema | 2.15.1 |
| fastparquet | 0.7.1 |
| fastprogress | 1.0.0 |
| fasttext | 0.9.2 |
| fb | 0.4.0 |
| fdk | 0.1.36 |
| feedgenerator | 1.9.2 |
| feedparser | 6.0.8 |
| ffmpeg-python | 0.2.0 |
| filelock | 3.0.12 |
| filetype | 1.0.7 |
| fiona | 1.8.20 |
| fire | 0.4.0 |
| firebase-admin | 5.0.2 |
| five-customerize | 2.0.1 |
| five-intid | 1.2.6 |
| five-localsitemanager | 3.2.2 |
| fixtures | 3.0.0 |
| flake8 | 2.3.0 |
| flake8 | 3.9.2 |
| flake8-black | 0.2.3 |
| flake8-bugbear | 21.9.1 |
| flake8-commas | 2.0.0 |
| flake8-comprehensions | 3.6.1 |
| flake8-docstrings | 1.6.0 |
| flake8-import-order | 0.18.1 |
| flake8-isort | 4.0.0 |
| flake8-polyfill | 1.0.2 |
| flake8-print | 4.0.0 |
| flake8-quotes | 3.3.0 |
| flask | 1.1.2 |
| flask | 1.1.4 |
| flask | 2.0.1 |
| flask-admin | 1.5.8 |
| flask-appbuilder | 3.3.2 |
| flask-babel | 1.0.0 |
| flask-babelex | 0.9.4 |
| flask-caching | 1.10.1 |
| flask-compress | 1.10.1 |
| flask-cors | 3.0.10 |
| flask-debugtoolbar | 0.11.0 |
| flask-httpauth | 4.4.0 |
| flask-jwt-extended | 3.25.1 |
| flask-login | 0.4.1 |
| flask-login | 0.5.0 |
| flask-mail | 0.9.1 |
| flask-marshmallow | 0.14.0 |
| flask-migrate | 3.1.0 |
| flask-moment | 1.0.2 |
| flask-openid | 1.3.0 |
| flask-pytest | 0.0.5 |
| flask-rbac | 0.5.0 |
| flask-restful | 0.3.9 |
| flask-restplus | 0.13.0 |
| flask-reverse-proxy | 0.2.0.2 |
| flask-script | 2.0.6 |
| flask-shell-ipython | 0.4.1 |
| flask-socketio | 5.1.1 |
| flask-sqlalchemy | 2.5.1 |
| flask-weasyprint | 0.6 |
| flask-wtf | 0.14.3 |
| flask-wtf | 0.15.1 |
| flatbuffers | 1.12 |
| flatbuffers | 2.0 |
| foliant | 1.0.12 |
| folium | 0.12.1 |
| fonttools | 4.26.2 |
| formal | 0.6.3 |
| fpdf | 1.7.2 |
| freetype-py | 2.2.0 |
| freezegun | 1.1.0 |
| frozendict | 2.0.6 |
| fs | 2.4.13 |
| fsspec | 2021.8.1 |
| ftfy | 6.0.3 |
| funcsigs | 1.0.2 |
| functools32 | 3.2.3-2 |
| funcy | 1.16 |
| furl | 2.1.2 |
| furo | 2021.9.8 |
| future | 0.18.2 |
| future-fstrings | 1.2.0 |
| futurist | 2.4.0 |
| fuzzywuzzy | 0.18.0 |
| gast | 0.4.0 |
| gast | 0.5.2 |
| gcsfs | 2021.8.1 |
| gdal | 3.3.2 |
| gdown | 3.13.1 |
| genshi | 0.7.5 |
| gensim | 4.1.0 |
| geoalchemy2 | 0.9.4 |
| geocoder | 1.38.1 |
| geographiclib | 1.52 |
| geoip2 | 4.2.0 |
| geojson | 2.5.0 |
| geomet | 0.2.1.post1 |
| geopandas | 0.9.0 |
| getdist | 1.3.2 |
| gevent | 21.8.0 |
| gg | 0.0.21 |
| ghp-import | 2.0.1 |
| gitdb | 4.0.7 |
| gitdb2 | 4.0.2 |
| github3-py | 2.0.0 |
| gitpython | 3.1.18 |
| gitpython | 3.1.20 |
| gitpython | 3.1.23 |
| gitpython | 3.1.24 |
| glob2 | 0.7 |
| gmpy2 | 2.0.8 |
| google | 3.0.0 |
| google-api-core | 1.31.2 |
| google-api-core | 2.0.1 |
| google-api-python-client | 1.12.8 |
| google-api-python-client | 2.20.0 |
| googleapis-common-protos | 1.53.0 |
| google-auth | 1.35.0 |
| google-auth | 2.0.2 |
| google-auth | 2.1.0 |
| google-auth-httplib2 | 0.1.0 |
| google-auth-oauthlib | 0.4.6 |
| google-cloud | 0.34.0 |
| google-cloud-appengine-logging | 0.1.4 |
| google-cloud-bigquery | 2.26.0 |
| google-cloud-core | 2.0.0 |
| google-cloud-datastore | 2.1.6 |
| google-cloud-firestore | 2.3.2 |
| google-cloud-logging | 2.6.0 |
| google-cloud-pubsub | 2.8.0 |
| google-cloud-storage | 1.42.2 |
| google-crc32c | 1.1.2 |
| google-pasta | 0.2.0 |
| google-resumable-media | 2.0.2 |
| googletrans | 3.0.0 |
| gpustat | 0.6.0 |
| gql | 2.0.0 |
| grapheme | 0.6.0 |
| graphene | 2.1.9 |
| graphene-django | 2.15.0 |
| graphql-core | 2.3.2 |
| graphql-core | 3.1.6 |
| graphql-relay | 2.0.1 |
| graphviz | 0.17 |
| greeking | 2.2.0 |
| greenlet | 1.1.1 |
| grequests | 0.6.0 |
| grpc-google-iam-v1 | 0.12.3 |
| grpcio | 1.39.0 |
| grpcio | 1.40.0 |
| grpcio-health-checking | 1.40.0 |
| grpcio-tools | 1.40.0 |
| gspread | 4.0.1 |
| gtts | 2.2.3 |
| gunicorn | 20.1.0 |
| gym | 0.19.0 |
| h11 | 0.12.0 |
| h11 | 0.9.0 |
| h2 | 3.2.0 |
| h5py | 3.1.0 |
| h5py | 3.2.1 |
| h5py | 3.4.0 |
| halo | 0.0.31 |
| hdfs3 | 0.3.1 |
| healpy | 1.15.0 |
| heapdict | 1.0.1 |
| hexbytes | 0.2.2 |
| hidapi | 0.10.1 |
| hiredis | 2.0.0 |
| holidays | 0.11.2 |
| holoviews | 1.14.6 |
| hpack | 3.0.0 |
| hsluv | 5.0.2 |
| hstspreload | 2021.9.1 |
| html2text | 2020.1.16 |
| html5lib | 1.1 |
| httpcore | 0.13.3 |
| httpcore | 0.13.6 |
| httpcore | 0.9.1 |
| httpexceptor | 1.4.0 |
| httplib2 | 0.19.1 |
| httpretty | 1.1.4 |
| httptools | 0.3.0 |
| httpx | 0.13.3 |
| httpx | 0.19.0 |
| huaweicloudsdkcore | 3.0.60 |
| huggingface-hub | 0.0.16 |
| huggingface-hub | 0.0.17 |
| humanfriendly | 10.0 |
| humanfriendly | 9.2 |
| humanize | 3.11.0 |
| hupper | 1.10.3 |
| hvac | 0.11.0 |
| hydra-core | 1.1.1 |
| hyperframe | 5.2.0 |
| hyperlink | 21.0.0 |
| hyperopt | 0.2.5 |
| hypothesis | 6.20.1 |
| icalendar | 4.0.7 |
| identify | 2.2.14 |
| idna | 2.10 |
| idna | 3.2 |
| idna-ssl | 1.1.0 |
| ifaddr | 0.1.7 |
| ijson | 3.1.4 |
| imageio | 2.9.0 |
| imageio-ffmpeg | 0.4.5 |
| imagesize | 1.2.0 |
| imapclient | 2.2.0 |
| imbalanced-learn | 0.8.0 |
| imgaug | 0.4.0 |
| immutables | 0.16 |
| importlib-metadata | 1.7.0 |
| importlib-metadata | 4.8.1 |
| importlib-resources | 1.5.0 |
| importlib-resources | 3.3.1 |
| importlib-resources | 5.2.2 |
| imutils | 0.5.4 |
| incremental | 21.3.0 |
| inflect | 5.3.0 |
| inflection | 0.5.1 |
| influxdb | 5.3.1 |
| iniconfig | 1.1.1 |
| inquirer | 2.7.0 |
| int-date | 0.1.8 |
| intervaltree | 3.1.0 |
| invoke | 1.6.0 |
| ipaddress | 1.0.23 |
| ipdb | 0.13.9 |
| ipfshttpclient | 0.8.0a2 |
| ipy | 1.01 |
| ipykernel | 5.5.5 |
| ipykernel | 6.4.1 |
| ipython | 7.16.1 |
| ipython | 7.27.0 |
| ipython-genutils | 0.2.0 |
| ipywidgets | 7.6.5 |
| iso8601 | 0.1.12 |
| iso8601 | 0.1.16 |
| isodate | 0.6.0 |
| isomer | 1.0.0 |
| isort | 5.8.0 |
| isort | 5.9.3 |
| itemadapter | 0.4.0 |
| itemloaders | 1.0.4 |
| itk | 5.2.1.post1 |
| itk-core | 5.2.1.post1 |
| itk-filtering | 5.2.1.post1 |
| itk-io | 5.2.1.post1 |
| itk-numerics | 5.2.1.post1 |
| itk-registration | 5.2.1.post1 |
| itk-segmentation | 5.2.1.post1 |
| itsdangerous | 1.1.0 |
| itsdangerous | 2.0.1 |
| itypes | 1.2.0 |
| janus | 0.6.1 |
| jaraco-classes | 3.2.1 |
| jaraco-collections | 3.4.0 |
| jaraco-functools | 3.3.0 |
| jaraco-packaging | 8.2.1 |
| jaraco-text | 3.5.1 |
| javaproperties | 0.8.0 |
| jax | 0.2.20 |
| jaxlib | 0.1.71 |
| jdcal | 1.4.1 |
| jedi | 0.18.0 |
| jeepney | 0.7.1 |
| jellyfish | 0.8.8 |
| jieba | 0.42.1 |
| jinja2 | 2.11.3 |
| jinja2 | 3.0.1 |
| jinja2-time | 0.2.0 |
| jinja2-webpack | 0.2.0 |
| jinxed | 1.1.0 |
| jira | 3.0.1 |
| jmespath | 0.10.0 |
| joblib | 1.0.1 |
| josepy | 1.9.0 |
| jpype1 | 1.3.0 |
| js2py | 0.71 |
| jsii | 0.13.4 |
| jsii | 1.34.0 |
| jsmin | 2.2.2 |
| json5 | 0.9.6 |
| jsondiff | 1.3.0 |
| jsonfield | 3.1.0 |
| jsonpatch | 1.32 |
| jsonpath-ng | 1.5.3 |
| jsonpath-rw | 1.4.0 |
| jsonpickle | 2.0.0 |
| jsonpointer | 2.1 |
| jsonschema | 2.6.0 |
| jsonschema | 3.2.0 |
| junit-xml | 1.9 |
| jupyter | 1.0.0 |
| jupyter-alabaster-theme | 0.4.0 |
| jupyter-client | 6.1.13 |
| jupyter-client | 7.0.3 |
| jupyter-console | 6.4.0 |
| jupyter-contrib-core | 0.3.3 |
| jupyter-contrib-nbextensions | 0.5.1 |
| jupyter-core | 4.8.1 |
| jupyterhub | 1.4.2 |
| jupyterlab | 3.1.12 |
| jupyterlab-pygments | 0.1.2 |
| jupyterlab-widgets | 1.0.1 |
| jupyterlab-widgets | 1.0.2 |
| jupyter-server | 1.11.0 |
| jupyter-sphinx | 0.3.2 |
| jupyter-telemetry | 0.1.0 |
| jupytext | 1.12.0 |
| jwcrypto | 1.0 |
| kazoo | 2.8.0 |
| keras | 2.6.0 |
| keras-applications | 1.0.8 |
| keras-preprocessing | 1.1.2 |
| keyboard | 0.13.5 |
| keyring | 21.8.0 |
| keyring | 23.1.0 |
| keyring | 23.2.1 |
| keyrings-alt | 4.1.0 |
| keystoneauth1 | 4.4.0 |
| keystonemiddleware | 9.3.0 |
| kivy | 2.0.0 |
| kivy-garden | 0.1.4 |
| kiwisolver | 1.3.1 |
| kiwisolver | 1.3.2 |
| knack | 0.8.2 |
| kombu | 4.6.11 |
| kombu | 5.1.0 |
| kubernetes | 18.20.0 |
| l18n | 2020.6.1 |
| langdetect | 1.0.9 |
| lark-parser | 0.10.1 |
| lark-parser | 0.11.3 |
| latexcodec | 2.0.1 |
| lazy-object-proxy | 1.6.0 |
| lazyutils | 0.3.3 |
| ldap3 | 2.9.1 |
| libcst | 0.3.20 |
| libsass | 0.21.0 |
| lightgbm | 3.2.1 |
| linecache2 | 1.0.0 |
| livereload | 2.6.3 |
| lizard | 1.17.9 |
| llvmlite | 0.36.0 |
| llvmlite | 0.37.0 |
| lmdb | 1.2.1 |
| lmfit | 1.0.2 |
| lob | 4.2.0 |
| localstack-client | 1.23 |
| locket | 0.2.1 |
| lockfile | 0.12.2 |
| logbook | 1.5.3 |
| logging | 0.4.9.6 |
| log-symbols | 0.0.14 |
| loguru | 0.5.3 |
| logzero | 1.7.0 |
| lru-dict | 1.1.7 |
| luigi | 3.0.3 |
| lxml | 4.6.3 |
| lz4 | 3.1.3 |
| m2crypto | 0.38.0 |
| m2r | 0.2.1 |
| m2r2 | 0.3.1 |
| m9s-trytond | 5.2.28 |
| magicgui | 0.2.11 |
| mailchimp-marketing | 3.0.59 |
| mako | 1.1.5 |
| mandrill-really-maintained | 1.2.4 |
| markdown | 3.3.4 |
| markdown2 | 2.4.1 |
| markdown-checklist | 0.4.3 |
| markdown-it-py | 1.1.0 |
| markupsafe | 1.1.1 |
| markupsafe | 2.0.1 |
| marshmallow | 3.13.0 |
| marshmallow-enum | 1.5.1 |
| marshmallow-oneofschema | 3.0.1 |
| marshmallow-polyfield | 5.10 |
| marshmallow-sqlalchemy | 0.23.1 |
| masonite-cli | 2.2.2 |
| matplotlib | 3.3.4 |
| matplotlib | 3.4.3 |
| matplotlib-inline | 0.1.2 |
| matplotlib-inline | 0.1.3 |
| maturin | 0.11.3 |
| maxminddb | 2.0.3 |
| maya | 0.6.1 |
| mccabe | 0.6.1 |
| mdit-py-plugins | 0.2.8 |
| mdp | 3.6 |
| mechanicalsoup | 1.1.0 |
| memoize | 1.0.0 |
| memory-profiler | 0.58.0 |
| mergedeep | 1.3.4 |
| meshio | 5.0.0 |
| metaloaders | 20.9.2566091 |
| mimeparse | 0.1.3 |
| minio | 7.1.0 |
| mirakuru | 2.4.1 |
| missing | 4.1 |
| mistune | 0.8.4 |
| mixpanel | 4.9.0 |
| mkdocs | 1.2.2 |
| mkdocs-autorefs | 0.2.1 |
| mkdocstrings | 0.15.2 |
| mlflow | 1.20.2 |
| mmh3 | 3.0.0 |
| mne | 0.23.4 |
| mnemonic | 0.20 |
| mock | 4.0.3 |
| mockup | 3.2.6 |
| mongoengine | 0.23.1 |
| monotonic | 1.6 |
| monty | 2021.8.17 |
| mopidy | 3.2.0 |
| more-itertools | 8.10.0 |
| more-itertools | 8.4.0 |
| more-itertools | 8.8.0 |
| more-itertools | 8.9.0 |
| moto | 2.2.6 |
| motor | 2.5.1 |
| mouseinfo | 0.1.3 |
| moviepy | 1.0.3 |
| mpi4py | 3.1.1 |
| mpmath | 1.2.1 |
| mrcfile | 1.3.0 |
| msal | 1.14.0 |
| msal-extensions | 0.3.0 |
| msgpack | 1.0.2 |
| msgpack-python | 0.5.6 |
| msprime | 1.0.2 |
| msrest | 0.6.21 |
| msrestazure | 0.6.4 |
| multiaddr | 0.0.9 |
| multidict | 5.1.0 |
| multimapping | 4.1 |
| multipart | 0.2.4 |
| multipledispatch | 0.6.0 |
| multiprocess | 0.70.12.2 |
| multitasking | 0.0.9 |
| munch | 2.5.0 |
| murmurhash | 1.0.5 |
| mutagen | 1.45.1 |
| mypy | 0.910 |
| mypy-boto3 | 1.18.44 |
| mypy-extensions | 0.4.3 |
| mysql-connector | 2.2.9 |
| mysql-connector-python | 8.0.26 |
| myst-parser | 0.15.2 |
| nameko | 2.13.0 |
| napari | 0.4.11 |
| napari-console | 0.0.4 |
| napari-plugin-engine | 0.2.0 |
| napari-svg | 0.1.5 |
| natsort | 7.1.1 |
| nbclient | 0.5.1 |
| nbclient | 0.5.4 |
| nbconvert | 6.0.7 |
| nbconvert | 6.1.0 |
| nbformat | 5.1.3 |
| nbsphinx | 0.8.7 |
| nbsphinx-link | 1.3.0 |
| nbval | 0.9.6 |
| ndg-httpsclient | 0.5.1 |
| nest-asyncio | 1.5.1 |
| netaddr | 0.8.0 |
| netcdf4 | 1.5.7 |
| netifaces | 0.11.0 |
| netron | 5.2.2 |
| networkx | 2.5.1 |
| networkx | 2.6.2 |
| networkx | 2.6.3 |
| newick | 1.3.0 |
| newrelic | 6.8.1.164 |
| nibabel | 3.2.1 |
| nilearn | 0.8.1 |
| nltk | 3.6.2 |
| nodeenv | 1.6.0 |
| nose | 1.3.7 |
| nose2 | 0.10.0 |
| nose-test-select | 0.3 |
| nosexcover | 1.0.11 |
| notebook | 6.4.4 |
| nox | 2021.6.12 |
| ntlm-auth | 1.5.0 |
| nuitka | 0.6.16.4 |
| numba | 0.53.1 |
| numba | 0.54.0 |
| numexpr | 2.7.3 |
| numpy | 1.19.5 |
| numpy | 1.20.3 |
| numpy | 1.21.2 |
| numpydoc | 1.1.0 |
| nvidia-ml-py3 | 7.352.0 |
| oauth2 | 1.9.0.post1 |
| oauth2client | 4.1.3 |
| oauthlib | 3.1.1 |
| olefile | 0.46 |
| omegaconf | 2.1.1 |
| on-http-redfish-1-0 | 1.0.9 |
| onnx | 1.10.1 |
| onnxruntime | 1.8.1 |
| openapi-schema-validator | 0.1.5 |
| openapi-spec-validator | 0.3.1 |
| opencl4py | 1.5.1 |
| opencv-contrib-python | 4.5.3.56 |
| opencv-python | 4.5.2.54 |
| opencv-python | 4.5.3.56 |
| opencv-python-headless | 4.5.2.54 |
| opencv-python-headless | 4.5.3.56 |
| openpyxl | 3.0.7 |
| openstacksdk | 0.59.0 |
| opentelemetry-api | 1.5.0 |
| opentelemetry-instrumentation | 0.24b0 |
| opentelemetry-sdk | 1.5.0 |
| opentracing | 2.4.0 |
| opt-einsum | 3.3.0 |
| optuna | 2.9.1 |
| ordereddict | 1.1 |
| orderedmultidict | 1.0.1 |
| ordered-set | 4.0.2 |
| orjson | 3.6.3 |
| osc-lib | 2.4.2 |
| oscrypto | 1.2.1 |
| oslo-cache | 2.8.1 |
| oslo-concurrency | 4.4.1 |
| oslo-config | 8.7.1 |
| oslo-context | 3.3.1 |
| oslo-db | 11.0.0 |
| oslo-i18n | 5.1.0 |
| oslo-log | 4.6.0 |
| oslo-messaging | 12.9.1 |
| oslo-metrics | 0.3.0 |
| oslo-policy | 3.8.2 |
| oslo-serialization | 4.2.0 |
| oslo-service | 2.6.0 |
| oslosphinx | 4.18.0 |
| oslo-utils | 4.10.0 |
| oss2 | 2.15.0 |
| os-service-types | 1.7.0 |
| outcome | 1.1.0 |
| oyaml | 1.0 |
| packaging | 20.9 |
| packaging | 21.0 |
| paho-mqtt | 1.5.1 |
| palettable | 3.3.0 |
| pamela | 1.0.0 |
| pamqp | 2.3.0 |
| pandas | 0.25.3 |
| pandas | 1.1.5 |
| pandas | 1.3.2 |
| pandas | 1.3.3 |
| pandas-datareader | 0.10.0 |
| pandoc | 1.1.0 |
| pandocfilters | 1.4.3 |
| pandocfilters | 1.5.0 |
| panel | 0.12.1 |
| panel | 0.12.3 |
| papermill | 2.3.3 |
| para | 0.0.8 |
| param | 1.11.1 |
| parameterized | 0.8.1 |
| paramiko | 2.7.2 |
| parse | 1.19.0 |
| parsedatetime | 2.6 |
| parsel | 1.6.0 |
| parse-type | 0.5.2 |
| parsimonious | 0.8.1 |
| parso | 0.8.2 |
| partd | 1.2.0 |
| passlib | 1.7.4 |
| paste | 3.5.0 |
| pastedeploy | 2.1.1 |
| pastel | 0.1.1 |
| pastel | 0.2.1 |
| path | 16.2.0 |
| pathlib | 1.0.1 |
| pathlib2 | 2.3.6 |
| pathos | 0.2.8 |
| path-py | 12.5.0 |
| pathspec | 0.9.0 |
| pathtools | 0.1.2 |
| pathvalidate | 2.4.1 |
| pathy | 0.6.0 |
| patsy | 0.5.1 |
| pbr | 5.4.5 |
| pbr | 5.6.0 |
| pdbpp | 0.10.3 |
| pdf2image | 1.16.0 |
| pdfminer-six | 20201018 |
| pdoc3 | 0.10.0 |
| peewee | 3.14.4 |
| pefile | 2021.9.3 |
| pelican | 4.6.0 |
| pendulum | 2.1.2 |
| pep517 | 0.11.0 |
| pep562 | 1.1 |
| pep8 | 1.7.1 |
| pep8-naming | 0.10.0 |
| pep8-naming | 0.12.1 |
| peppercorn | 0.6 |
| persistence | 3.1 |
| persistent | 4.7.0 |
| pexpect | 4.8.0 |
| phonenumbers | 8.12.31 |
| pickleshare | 0.7.5 |
| piexif | 1.1.3 |
| pika | 1.2.0 |
| pillow | 8.3.1 |
| pillow | 8.3.2 |
| pint | 0.17 |
| pip | 21.2.4 |
| pip-check | 2.6 |
| pip-check-reqs | 2.3.0 |
| pipenv | 2021.5.29 |
| pip-tools | 6.2.0 |
| pip-upgrader | 1.4.15 |
| pkginfo | 1.7.1 |
| plac | 1.3.3 |
| plantweb | 1.2.1 |
| plaster | 1.0 |
| plaster-pastedeploy | 0.7 |
| platformdirs | 2.3.0 |
| playsound | 1.3.0 |
| plexauth | 0.0.6 |
| plone | 5.2.5 |
| plone-alterego | 1.1.5 |
| plone-api | 1.11.0 |
| plone-app-caching | 2.1.0 |
| plone-app-content | 3.8.8 |
| plone-app-content | 4.0.0a5 |
| plone-app-contentlisting | 2.0.4 |
| plone-app-contentmenu | 2.3.4 |
| plone-app-contentrules | 4.1.6 |
| plone-app-contenttypes | 2.2.2 |
| plone-app-customerize | 1.3.11 |
| plone-app-dexterity | 2.6.9 |
| plone-app-discussion | 3.4.4 |
| plone-app-event | 4.0.0a5 |
| plone-app-i18n | 3.0.6 |
| plone-app-intid | 1.1.4 |
| plone-app-layout | 3.4.6 |
| plone-app-layout | 4.0.0a3 |
| plone-app-linkintegrity | 3.4.1 |
| plone-app-locales | 5.1.29 |
| plone-app-lockingbehavior | 1.0.7 |
| plone-app-multilingual | 5.6.3 |
| plone-app-portlets | 4.4.7 |
| plone-app-querystring | 1.4.15 |
| plone-app-redirector | 2.2.1 |
| plone-app-registry | 1.7.9 |
| plone-app-registry | 2.0.0a4 |
| plone-app-relationfield | 2.0.3 |
| plone-app-testing | 6.1.9 |
| plone-app-textfield | 1.3.5 |
| plone-app-theming | 4.1.7 |
| plone-app-users | 2.6.6 |
| plone-app-uuid | 2.0.2 |
| plone-app-versioningbehavior | 1.4.3 |
| plone-app-viewletmanager | 3.1.2 |
| plone-app-vocabularies | 4.3.0 |
| plone-app-widgets | 3.0.6 |
| plone-app-workflow | 4.0.4 |
| plone-app-z3cform | 3.2.2 |
| plone-autoform | 1.9.0 |
| plone-batching | 1.1.7 |
| plone-behavior | 1.4.0 |
| plone-browserlayer | 2.2.4 |
| plone-cachepurging | 2.0.3 |
| plone-caching | 1.2.2 |
| plone-contentrules | 2.1.2 |
| plone-dexterity | 2.10.3 |
| plone-event | 1.4.1 |
| plone-folder | 3.1.0 |
| plone-formwidget-namedfile | 2.1.3 |
| plone-formwidget-recurrence | 2.1.4 |
| plone-i18n | 4.0.6 |
| plone-i18n | 5.0.0a1 |
| plone-indexer | 1.0.7 |
| plone-intelligenttext | 3.1.0 |
| plone-keyring | 3.1.3 |
| plone-locking | 2.2.4 |
| plone-memoize | 2.1.1 |
| plone-namedfile | 5.5.1 |
| plone-outputfilters | 4.0.2 |
| plone-portlet-collection | 3.3.6 |
| plone-portlets | 2.3.2 |
| plone-portlet-static | 3.1.6 |
| plone-protect | 4.1.6 |
| plone-registry | 1.2.1 |
| plone-resource | 2.1.4 |
| plone-resourceeditor | 3.0.3 |
| plone-rfc822 | 2.0.2 |
| plone-scale | 3.1.2 |
| plone-schema | 1.3.0 |
| plone-schemaeditor | 3.0.3 |
| plone-session | 3.7.5 |
| plone-staticresources | 1.4.3 |
| plone-stringinterp | 1.3.3 |
| plone-subrequest | 1.9.3 |
| plone-supermodel | 1.6.4 |
| plone-synchronize | 1.0.4 |
| plone-testing | 8.0.3 |
| plone-theme | 3.0.7 |
| plonetheme-barceloneta | 2.1.10 |
| plone-transformchain | 2.0.2 |
| plone-uuid | 1.0.6 |
| plone-z3cform | 2.0.0a1 |
| plotly | 5.3.1 |
| plotly-express | 0.4.1 |
| plotnine | 0.8.0 |
| plover | 3.1.1 |
| pluggy | 0.13.1 |
| pluggy | 1.0.0 |
| plumbum | 1.7.0 |
| ply | 3.11 |
| plyplus | 0.7.5 |
| pockets | 0.9.1 |
| poetry | 1.1.9 |
| poetry-core | 1.0.5 |
| polib | 1.1.1 |
| pooch | 1.5.1 |
| portalocker | 1.7.1 |
| portalocker | 2.3.2 |
| portend | 2.7.1 |
| port-for | 0.6.1 |
| pox | 0.3.0 |
| poyo | 0.5.0 |
| ppft | 1.6.6.4 |
| praw | 7.4.0 |
| prawcore | 2.3.0 |
| pre-commit | 2.15.0 |
| preshed | 3.0.5 |
| prestring | 0.9.0 |
| pretend | 1.0.9 |
| prettytable | 2.2.0 |
| priority | 1.3.0 |
| prison | 0.2.1 |
| products-btreefolder2 | 4.3 |
| products-cmfcore | 2.5.4 |
| products-cmfdifftool | 3.3.3 |
| products-cmfdynamicviewfti | 6.0.3 |
| products-cmfeditions | 3.3.4 |
| products-cmfformcontroller | 4.1.4 |
| products-cmfplone | 5.2.5 |
| products-cmfquickinstallertool | 4.0.4 |
| products-cmfuid | 3.2.0 |
| products-daterecurringindex | 3.0.1 |
| products-dcworkflow | 2.5.0 |
| products-extendedpathindex | 4.0.1 |
| products-externalmethod | 4.5 |
| products-genericsetup | 2.1.4 |
| products-isurlinportal | 1.2.1 |
| products-mailhost | 4.11 |
| products-mimetypesregistry | 2.1.8 |
| products-plonepas | 6.0.8 |
| products-pluggableauthservice | 2.6.4 |
| products-pluginregistry | 1.9 |
| products-portaltransforms | 3.1.12 |
| products-pythonscripts | 4.13 |
| products-sessions | 4.12 |
| products-siteerrorlog | 5.5 |
| products-standardcachemanagers | 4.1.1 |
| products-statusmessages | 5.0.5 |
| products-temporaryfolder | 6.2 |
| products-zcatalog | 6.0 |
| products-zodbmountpoint | 1.2 |
| products-zopeversioncontrol | 2.0.0 |
| profanityfilter | 2.0.6 |
| proglog | 0.1.9 |
| progress | 1.6 |
| progressbar | 2.5 |
| progressbar2 | 3.53.3 |
| prometheus-client | 0.11.0 |
| prometheus-flask-exporter | 0.18.2 |
| promise | 2.3 |
| prompt-toolkit | 1.0.14 |
| prompt-toolkit | 2.0.10 |
| prompt-toolkit | 3.0.20 |
| prompt-toolkit | 3.0.3 |
| prospector | 1.5.0.1 |
| protego | 0.1.16 |
| protobuf | 3.17.3 |
| protobuf | 3.18.0 |
| protobuf3-to-dict | 0.1.5 |
| proto-plus | 1.19.0 |
| psutil | 5.8.0 |
| psycopg2 | 2.9.1 |
| psycopg2-binary | 2.9.1 |
| ptyprocess | 0.7.0 |
| public | 2020.12.3 |
| publication | 0.0.3 |
| pulp | 2.5.0 |
| pulumi | 3.12.0 |
| purplex | 0.2.4 |
| py | 1.10.0 |
| py4j | 0.10.9 |
| pyaes | 1.6.1 |
| pyaml | 21.8.3 |
| pyarrow | 5.0.0 |
| pyasn1 | 0.4.8 |
| pyasn1-modules | 0.2.8 |
| pyaudio | 0.2.11 |
| pyautogui | 0.9.53 |
| pybedtools | 0.8.2 |
| pybind11 | 2.7.1 |
| pybtex | 0.24.0 |
| pybtex-docutils | 1.0.1 |
| pycairo | 1.20.1 |
| pycalver | 202010.1043 |
| pycares | 4.0.0 |
| pycocotools | 2.0.0 |
| pycodestyle | 2.7.0 |
| pycountry | 20.7.3 |
| pycparser | 2.20 |
| py-cpuinfo | 8.0.0 |
| pycricbuzz | 2.4 |
| pycrypto | 2.6.1 |
| pycryptodome | 3.10.1 |
| pycryptodomex | 3.10.1 |
| pyct | 0.4.8 |
| pycurl | 7.44.1 |
| pydantic | 1.7.4 |
| pydantic | 1.8.2 |
| pydash | 5.0.2 |
| pydata-sphinx-theme | 0.6.3 |
| pydeck | 0.6.2 |
| pydeck | 0.7.0 |
| pydeprecate | 0.3.1 |
| pydeps | 1.9.14 |
| pydicom | 2.2.1 |
| pydispatcher | 2.0.5 |
| pydocstyle | 6.1.1 |
| pydot | 1.4.2 |
| pydotplus | 2.0.2 |
| pydriller | 2.0 |
| pydub | 0.25.1 |
| pydyf | 0.1.1 |
| pyecharts | 1.9.0 |
| pyee | 8.2.2 |
| pyelftools | 0.27 |
| pyenchant | 3.2.1 |
| pyerfa | 2.0.0 |
| pyexcelerate | 0.10.0 |
| pyfaidx | 0.6.2 |
| pyfakefs | 4.5.1 |
| pyflakes | 2.2.0 |
| pyflakes | 2.3.1 |
| pyftdi | 0.53.3 |
| pygame | 2.0.1 |
| pygetwindow | 0.0.9 |
| pygit2 | 1.6.1 |
| pygithub | 1.55 |
| pyglet | 1.5.21 |
| pygments | 2.10.0 |
| pygobject | 3.40.1 |
| pygraphviz | 1.7 |
| pyhamcrest | 2.0.2 |
| pyhunter | 1.7 |
| pyinotify | 0.9.6 |
| pyinquirer | 1.0.3 |
| pyinstaller | 4.5.1 |
| pyinstaller-hooks-contrib | 2021.3 |
| pyjsparser | 2.7.1 |
| pyjwt | 1.7.1 |
| pyjwt | 2.1.0 |
| pykerberos | 1.2.1 |
| pykka | 3.0.1 |
| pykwalify | 1.8.0 |
| pylev | 1.4.0 |
| pylg | 1.3.3 |
| pylint | 2.10.2 |
| pylint-celery | 0.3 |
| pylint-django | 2.4.4 |
| pylint-flask | 0.6 |
| pylint-plugin-utils | 0.6 |
| pymatgen | 2022.0.14 |
| pymc3 | 3.11.4 |
| pymdown-extensions | 8.2 |
| pymeeus | 0.5.11 |
| pymongo | 3.12.0 |
| pymsgbox | 1.0.9 |
| pymssql | 2.2.2 |
| pymsteams | 0.1.15 |
| pymupdf | 1.18.19 |
| pymysql | 0.9.3 |
| pymysql | 1.0.2 |
| pynacl | 1.4.0 |
| pynamodb | 5.1.0 |
| pynndescent | 0.5.4 |
| pynput | 1.7.3 |
| pynvml | 11.0.0 |
| pyobjc | 7.3 |
| pyobjc-core | 7.3 |
| pyobjc-framework-accessibility | 7.3 |
| pyobjc-framework-accounts | 7.3 |
| pyobjc-framework-addressbook | 7.3 |
| pyobjc-framework-adservices | 7.3 |
| pyobjc-framework-adsupport | 7.3 |
| pyobjc-framework-applescriptkit | 7.3 |
| pyobjc-framework-applescriptobjc | 7.3 |
| pyobjc-framework-applicationservices | 7.3 |
| pyobjc-framework-apptrackingtransparency | 7.3 |
| pyobjc-framework-authenticationservices | 7.3 |
| pyobjc-framework-automaticassessmentconfiguration | 7.3 |
| pyobjc-framework-automator | 7.3 |
| pyobjc-framework-avfoundation | 7.3 |
| pyobjc-framework-avkit | 7.3 |
| pyobjc-framework-businesschat | 7.3 |
| pyobjc-framework-calendarstore | 7.3 |
| pyobjc-framework-callkit | 7.3 |
| pyobjc-framework-cfnetwork | 7.3 |
| pyobjc-framework-classkit | 7.3 |
| pyobjc-framework-cloudkit | 7.3 |
| pyobjc-framework-cocoa | 7.3 |
| pyobjc-framework-collaboration | 7.3 |
| pyobjc-framework-colorsync | 7.3 |
| pyobjc-framework-contacts | 7.3 |
| pyobjc-framework-contactsui | 7.3 |
| pyobjc-framework-coreaudio | 7.3 |
| pyobjc-framework-coreaudiokit | 7.3 |
| pyobjc-framework-corebluetooth | 7.3 |
| pyobjc-framework-coredata | 7.3 |
| pyobjc-framework-corehaptics | 7.3 |
| pyobjc-framework-corelocation | 7.3 |
| pyobjc-framework-coremedia | 7.3 |
| pyobjc-framework-coremediaio | 7.3 |
| pyobjc-framework-coremidi | 7.3 |
| pyobjc-framework-coreml | 7.3 |
| pyobjc-framework-coremotion | 7.3 |
| pyobjc-framework-coreservices | 7.3 |
| pyobjc-framework-corespotlight | 7.3 |
| pyobjc-framework-coretext | 7.3 |
| pyobjc-framework-corewlan | 7.3 |
| pyobjc-framework-cryptotokenkit | 7.3 |
| pyobjc-framework-devicecheck | 7.3 |
| pyobjc-framework-dictionaryservices | 7.3 |
| pyobjc-framework-discrecording | 7.3 |
| pyobjc-framework-discrecordingui | 7.3 |
| pyobjc-framework-diskarbitration | 7.3 |
| pyobjc-framework-dvdplayback | 7.3 |
| pyobjc-framework-eventkit | 7.3 |
| pyobjc-framework-exceptionhandling | 7.3 |
| pyobjc-framework-executionpolicy | 7.3 |
| pyobjc-framework-externalaccessory | 7.3 |
| pyobjc-framework-fileprovider | 7.3 |
| pyobjc-framework-fileproviderui | 7.3 |
| pyobjc-framework-findersync | 7.3 |
| pyobjc-framework-fsevents | 7.3 |
| pyobjc-framework-gamecenter | 7.3 |
| pyobjc-framework-gamecontroller | 7.3 |
| pyobjc-framework-gamekit | 7.3 |
| pyobjc-framework-gameplaykit | 7.3 |
| pyobjc-framework-imagecapturecore | 7.3 |
| pyobjc-framework-imserviceplugin | 7.3 |
| pyobjc-framework-inputmethodkit | 7.3 |
| pyobjc-framework-installerplugins | 7.3 |
| pyobjc-framework-instantmessage | 7.3 |
| pyobjc-framework-intents | 7.3 |
| pyobjc-framework-interfacebuilderkit | 7.3 |
| pyobjc-framework-iosurface | 7.3 |
| pyobjc-framework-ituneslibrary | 7.3 |
| pyobjc-framework-kernelmanagement | 7.3 |
| pyobjc-framework-latentsemanticmapping | 7.3 |
| pyobjc-framework-launchservices | 7.3 |
| pyobjc-framework-libdispatch | 7.3 |
| pyobjc-framework-linkpresentation | 7.3 |
| pyobjc-framework-localauthentication | 7.3 |
| pyobjc-framework-mapkit | 7.3 |
| pyobjc-framework-mediaaccessibility | 7.3 |
| pyobjc-framework-medialibrary | 7.3 |
| pyobjc-framework-mediaplayer | 7.3 |
| pyobjc-framework-mediatoolbox | 7.3 |
| pyobjc-framework-message | 7.3 |
| pyobjc-framework-metal | 7.3 |
| pyobjc-framework-metalkit | 7.3 |
| pyobjc-framework-metalperformanceshaders | 7.3 |
| pyobjc-framework-metalperformanceshadersgraph | 7.3 |
| pyobjc-framework-mlcompute | 7.3 |
| pyobjc-framework-modelio | 7.3 |
| pyobjc-framework-multipeerconnectivity | 7.3 |
| pyobjc-framework-naturallanguage | 7.3 |
| pyobjc-framework-netfs | 7.3 |
| pyobjc-framework-network | 7.3 |
| pyobjc-framework-networkextension | 7.3 |
| pyobjc-framework-notificationcenter | 7.3 |
| pyobjc-framework-opendirectory | 7.3 |
| pyobjc-framework-osakit | 7.3 |
| pyobjc-framework-oslog | 7.3 |
| pyobjc-framework-passkit | 7.3 |
| pyobjc-framework-pencilkit | 7.3 |
| pyobjc-framework-photos | 7.3 |
| pyobjc-framework-photosui | 7.3 |
| pyobjc-framework-preferencepanes | 7.3 |
| pyobjc-framework-pubsub | 7.3 |
| pyobjc-framework-pushkit | 7.3 |
| pyobjc-framework-quartz | 7.3 |
| pyobjc-framework-quicklookthumbnailing | 7.3 |
| pyobjc-framework-replaykit | 7.3 |
| pyobjc-framework-safariservices | 7.3 |
| pyobjc-framework-scenekit | 7.3 |
| pyobjc-framework-screensaver | 7.3 |
| pyobjc-framework-screentime | 7.3 |
| pyobjc-framework-scriptingbridge | 7.3 |
| pyobjc-framework-searchkit | 7.3 |
| pyobjc-framework-security | 7.3 |
| pyobjc-framework-securityfoundation | 7.3 |
| pyobjc-framework-securityinterface | 7.3 |
| pyobjc-framework-servernotification | 7.3 |
| pyobjc-framework-servicemanagement | 7.3 |
| pyobjc-framework-social | 7.3 |
| pyobjc-framework-soundanalysis | 7.3 |
| pyobjc-framework-speech | 7.3 |
| pyobjc-framework-spritekit | 7.3 |
| pyobjc-framework-storekit | 7.3 |
| pyobjc-framework-syncservices | 7.3 |
| pyobjc-framework-systemconfiguration | 7.3 |
| pyobjc-framework-systemextensions | 7.3 |
| pyobjc-framework-uniformtypeidentifiers | 7.3 |
| pyobjc-framework-usernotifications | 7.3 |
| pyobjc-framework-usernotificationsui | 7.3 |
| pyobjc-framework-videosubscriberaccount | 7.3 |
| pyobjc-framework-videotoolbox | 7.3 |
| pyobjc-framework-virtualization | 7.3 |
| pyobjc-framework-vision | 7.3 |
| pyobjc-framework-webkit | 7.3 |
| pyodbc | 4.0.32 |
| pyomo | 6.1.2 |
| pyopengl | 3.1.5 |
| pyopenssl | 20.0.1 |
| pyotp | 2.6.0 |
| pypandoc | 1.6.3 |
| pyparsing | 2.4.7 |
| pypdf2 | 1.26.0 |
| pypdf4 | 1.27.0 |
| pyper | 1.1.2 |
| pyperclip | 1.8.2 |
| pyphen | 0.11.0 |
| pypinyin | 0.42.0 |
| pypiwin32 | 223 |
| pypng | 0.0.21 |
| pyppeteer | 0.0.25 |
| pyppeteer | 0.2.6 |
| pyproj | 3.2.1 |
| pypydispatcher | 2.1.2 |
| pyqrcode | 1.2.1 |
| pyqt5 | 5.15.4 |
| pyqt5-qt5 | 5.15.2 |
| pyqt5-sip | 12.9.0 |
| pyqtwebengine | 5.15.4 |
| pyqtwebengine-qt5 | 5.15.2 |
| pyquery | 1.4.3 |
| pyramid | 2.0 |
| pyreadline | 2.1 |
| pyreadline3 | 3.3 |
| pyrect | 0.1.4 |
| pyrelic | 0.8.0 |
| pyrepl | 0.9.0 |
| pyrfc3339 | 1.1 |
| pyrsistent | 0.18.0 |
| pysam | 0.16.0.1 |
| pyscreeze | 0.1.28 |
| pyscss | 1.3.7 |
| pyserial | 3.5 |
| pysftp | 0.2.9 |
| pysha3 | 1.0.2 |
| pyshp | 2.1.3 |
| pyside2 | 5.15.2 |
| pysimplegui | 4.47.0 |
| pysocks | 1.7.1 |
| pyspark | 3.1.2 |
| pystache | 0.5.4 |
| pytesseract | 0.3.8 |
| pytest | 5.4.3 |
| pytest | 6.2.4 |
| pytest | 6.2.5 |
| pytest-aiohttp | 0.3.0 |
| pytest-asyncio | 0.12.0 |
| pytest-asyncio | 0.15.1 |
| pytest-benchmark | 3.4.1 |
| pytest-black | 0.3.12 |
| pytest-cache | 1.0 |
| pytest-checkdocs | 2.7.1 |
| pytest-check-links | 0.5.2 |
| pytest-cov | 2.12.1 |
| pytest-datadir | 1.3.1 |
| pytest-django | 4.4.0 |
| pytest-flake8 | 1.0.7 |
| pytest-flask | 1.2.0 |
| pytest-forked | 1.3.0 |
| pytest-freezegun | 0.4.2 |
| pytest-html | 3.1.1 |
| pytest-invenio | 1.4.2 |
| pytest-isort | 2.0.0 |
| pytest-metadata | 1.11.0 |
| pytest-mock | 3.6.1 |
| pytest-mpl | 0.13 |
| pytest-mypy | 0.8.1 |
| pytest-postgresql | 3.1.1 |
| pytest-pycodestyle | 2.2.0 |
| pytest-pydocstyle | 2.2.0 |
| pytest-randomly | 3.10.1 |
| pytest-random-order | 1.0.4 |
| pytest-regressions | 2.2.0 |
| pytest-rerunfailures | 10.1 |
| pytest-runner | 5.3.1 |
| pytest-sugar | 0.9.4 |
| pytest-test-groups | 1.0.3 |
| pytest-timeout | 1.4.2 |
| pytest-toolbox | 0.4 |
| pytest-watch | 4.2.0 |
| pytest-xdist | 2.3.0 |
| python3-openid | 3.2.0 |
| python3-xlib | 0.15 |
| python-baseconv | 1.2.2 |
| python-box | 5.4.1 |
| python-cinderclient | 8.1.0 |
| python-constraint | 1.4.0 |
| python-consul | 1.1.0 |
| python-coveralls | 2.9.3 |
| python-crfsuite | 0.9.7 |
| python-crontab | 2.5.1 |
| python-daemon | 2.3.0 |
| python-dateutil | 2.8.2 |
| python-decouple | 3.4 |
| python-docx | 0.8.11 |
| python-dotenv | 0.19.0 |
| python-editor | 1.0.4 |
| python-engineio | 4.2.1 |
| python-gettext | 4.0 |
| python-git | 2018.2.1 |
| python-gitlab | 2.10.1 |
| python-glanceclient | 3.5.0 |
| python-gnupg | 0.4.7 |
| python-hcl2 | 3.0.1 |
| python-hosts | 1.0.1 |
| python-http-client | 3.3.2 |
| python-igraph | 0.9.6 |
| python-jose | 3.3.0 |
| python-json-logger | 2.0.2 |
| python-keystoneclient | 4.3.0 |
| python-ldap | 3.3.1 |
| python-magic | 0.4.24 |
| python-memcached | 1.59 |
| python-multipart | 0.0.5 |
| python-neutronclient | 7.6.0 |
| python-novaclient | 17.6.0 |
| python-openstackclient | 5.6.0 |
| python-rapidjson | 1.4 |
| python-slugify | 4.0.1 |
| python-slugify | 5.0.2 |
| python-snappy | 0.6.0 |
| python-socketio | 5.4.0 |
| python-sql | 1.2.2 |
| python-sql | 1.3.0 |
| python-stdnum | 1.16 |
| python-swiftclient | 3.12.0 |
| python-utils | 2.5.6 |
| python-whois | 0.7.3 |
| python-xlib | 0.31 |
| pytimeparse | 1.1.8 |
| pytodoist | 2.1.4 |
| pytoml | 0.1.21 |
| pytorch-lightning | 1.4.7 |
| pyttsx3 | 2.90 |
| pytube | 11.0.1 |
| pytweening | 1.0.3 |
| pytweening | 1.0.4 |
| pytz | 2021.1 |
| pytzdata | 2020.1 |
| pyusb | 1.2.1 |
| pyvisa | 1.11.3 |
| pyviz-comms | 2.1.0 |
| pyvo | 1.1 |
| pywavelets | 1.1.1 |
| pywin32 | 301 |
| pywin32-ctypes | 0.2.0 |
| pywinpty | 1.1.4 |
| pyxdg | 0.27 |
| pyyaml | 5.4.1 |
| pyyaml-env-tag | 0.1 |
| pyzmq | 22.2.1 |
| pyzmq | 22.3.0 |
| qdldl | 0.1.5.post0 |
| qiskit | 0.30.0 |
| qiskit-aer | 0.9.0 |
| qiskit-aqua | 0.9.5 |
| qiskit-ignis | 0.6.0 |
| qiskit-terra | 0.18.2 |
| qrcode | 7.3 |
| qtconsole | 5.1.1 |
| qtpy | 1.11.1 |
| quandl | 3.6.1 |
| querystring-parser | 1.2.4 |
| questionary | 1.10.0 |
| queuelib | 1.6.2 |
| rad | 0.1.2 |
| random2 | 1.0.1 |
| rasterio | 1.2.8 |
| ratelim | 0.1.6 |
| ratelimit | 2.2.1 |
| ratelimiter | 1.2.0.post0 |
| raven | 6.10.0 |
| ray | 1.6.0 |
| rcssmin | 1.0.6 |
| rdflib | 5.0.0 |
| rdflib | 6.0.0 |
| rdflib | 6.0.1 |
| rdflib-jsonld | 0.6.2 |
| readchar | 2.0.1 |
| readme-renderer | 29.0 |
| recommonmark | 0.7.1 |
| record | 3.5 |
| redis | 3.5.3 |
| redis-py-cluster | 2.1.3 |
| regetron | 1.4 |
| regex | 2021.8.28 |
| relatorio | 0.10.0 |
| relatorio | 0.9.3 |
| reportlab | 3.6.1 |
| repoze-lru | 0.7 |
| repoze-xmliter | 0.6 |
| requests | 2.25.1 |
| requests | 2.26.0 |
| requests-cache | 0.8.0 |
| requestsexceptions | 1.4.0 |
| requests-file | 1.5.1 |
| requests-futures | 1.0.0 |
| requests-html | 0.10.0 |
| requests-kerberos | 0.12.0 |
| requests-mock | 1.9.3 |
| requests-ntlm | 1.1.0 |
| requests-oauthlib | 1.3.0 |
| requests-toolbelt | 0.9.1 |
| requests-unixsocket | 0.2.0 |
| requirements-detector | 0.7 |
| resolvelib | 0.5.5 |
| responses | 0.13.4 |
| restrictedpython | 5.1 |
| restructuredtext-lint | 1.3.2 |
| retry | 0.9.2 |
| retrying | 1.3.3 |
| returns | 0.16.0 |
| retworkx | 0.10.2 |
| rfc3986 | 1.5.0 |
| rfc3987 | 1.3.8 |
| rgbxy | 0.5 |
| rich | 10.9.0 |
| rjsmin | 1.1.0 |
| rlp | 2.0.1 |
| robotframework | 4.1.1 |
| roman | 3.3 |
| rope | 0.19.0 |
| routes | 2.5.1 |
| rpi-gpio | 0.7.0 |
| rpy2 | 3.4.5 |
| rq | 1.9.0 |
| rsa | 4.7.2 |
| rst-linker | 2.2.0 |
| ruamel-yaml | 0.17.16 |
| ruamel-yaml | 0.17.4 |
| ruamel-yaml-clib | 0.2.6 |
| rubicon-objc | 0.4.1 |
| rx | 1.6.1 |
| s3fs | 2021.8.1 |
| s3transfer | 0.3.7 |
| s3transfer | 0.4.2 |
| s3transfer | 0.5.0 |
| sacremoses | 0.0.45 |
| safety | 1.10.3 |
| sagemaker | 2.56.0 |
| sanic | 21.6.2 |
| sanic-routing | 0.7.1 |
| scandir | 1.10.0 |
| scanpy | 1.8.1 |
| scapy | 2.4.5 |
| schedule | 1.1.0 |
| schema | 0.7.4 |
| schematics | 2.1.1 |
| scikit-image | 0.17.2 |
| scikit-image | 0.18.3 |
| scikit-learn | 0.24.2 |
| scikit-optimize | 0.8.1 |
| scipy | 1.5.4 |
| scipy | 1.7.1 |
| scp | 0.14.1 |
| scrapy | 2.5.0 |
| scripttest | 1.3 |
| scrypt | 0.8.18 |
| scs | 2.1.4 |
| seaborn | 0.11.2 |
| secretstorage | 3.3.1 |
| selenium | 3.141.0 |
| semantic-version | 2.8.5 |
| semver | 2.13.0 |
| send2trash | 1.8.0 |
| sendgrid | 6.8.1 |
| sentencepiece | 0.1.96 |
| sentence-transformers | 2.0.0 |
| sentry-sdk | 1.3.1 |
| service-identity | 21.1.0 |
| setoptconf | 0.2.0 |
| setproctitle | 1.2.2 |
| setuptools | 57.4.0 |
| setuptools-rust | 0.12.1 |
| setuptools-scm | 6.3.2 |
| sgmllib3k | 1.0.0 |
| sgqlc | 14.0 |
| sh | 1.14.2 |
| shap | 0.39.0 |
| shapely | 1.7.1 |
| sharedmem | 0.3.8 |
| shellingham | 1.4.0 |
| shiboken2 | 5.15.2 |
| shortuuid | 1.0.1 |
| sign | 0.0.2 |
| simpleeval | 0.9.10 |
| simplegeneric | 0.8.1 |
| simpleitk | 2.1.1 |
| simplejson | 3.11.1 |
| simplejson | 3.17.5 |
| sinfo | 0.3.4 |
| singer-python | 5.12.2 |
| singledispatch | 3.7.0 |
| six | 1.15.0 |
| six | 1.16.0 |
| skills | 0.3.0 |
| sklearn | 0.0 |
| sklearn-crfsuite | 0.3.6 |
| slackclient | 2.9.3 |
| slacker | 0.14.0 |
| slicer | 0.0.7 |
| smart-open | 5.2.1 |
| smbus2 | 0.4.1 |
| smdebug-rulesconfig | 1.0.1 |
| smmap | 4.0.0 |
| snaptime | 0.2.4 |
| sniffio | 1.2.0 |
| snowballstemmer | 2.1.0 |
| snowflake-connector-python | 2.6.1 |
| snuggs | 1.4.7 |
| social-auth-app-django | 5.0.0 |
| social-auth-core | 4.1.0 |
| sockjs | 0.11.0 |
| sortedcontainers | 2.4.0 |
| sounddevice | 0.4.2 |
| soundfile | 0.10.3.post1 |
| soupsieve | 2.2.1 |
| south | 1.0.2 |
| spacy | 3.1.2 |
| spacy-legacy | 3.0.8 |
| sparqlwrapper | 1.8.5 |
| speaklater | 1.3 |
| speechrecognition | 3.8.1 |
| spglib | 1.16.2 |
| sphinx | 4.1.2 |
| sphinx | 4.2.0 |
| sphinx-argparse | 0.3.1 |
| sphinx-autoapi | 1.8.4 |
| sphinx-autobuild | 2021.3.14 |
| sphinx-autodoc-typehints | 1.12.0 |
| sphinx-automodapi | 0.13 |
| sphinx-book-theme | 0.1.3 |
| sphinx-bootstrap-theme | 0.8.0 |
| sphinx-click | 3.0.1 |
| sphinxcontrib-apidoc | 0.3.0 |
| sphinxcontrib-applehelp | 1.0.2 |
| sphinxcontrib-bibtex | 2.4.1 |
| sphinxcontrib-devhelp | 1.0.2 |
| sphinxcontrib-htmlhelp | 2.0.0 |
| sphinxcontrib-jsmath | 1.0.1 |
| sphinxcontrib-napoleon | 0.7 |
| sphinxcontrib-programoutput | 0.17 |
| sphinxcontrib-qthelp | 1.0.3 |
| sphinxcontrib-serializinghtml | 1.1.5 |
| sphinxcontrib-spelling | 7.2.1 |
| sphinxcontrib-websupport | 1.2.4 |
| sphinx-copybutton | 0.4.0 |
| sphinx-gallery | 0.9.0 |
| sphinx-rtd-theme | 0.5.2 |
| spidev | 3.5 |
| spinners | 0.0.24 |
| spotipy | 2.19.0 |
| sqlalchemy | 1.3.24 |
| sqlalchemy | 1.4.23 |
| sqlalchemy-jsonfield | 1.0.0 |
| sqlalchemy-migrate | 0.13.0 |
| sqlalchemy-mixins | 1.5 |
| sqlalchemy-utils | 0.37.8 |
| sqlite-fts4 | 1.0.1 |
| sqlite-utils | 3.17 |
| sqlparse | 0.4.1 |
| sqlparse | 0.4.2 |
| srsly | 2.4.1 |
| sshtunnel | 0.4.0 |
| stanfordnlp | 0.2.0 |
| starkbank-ecdsa | 1.1.1 |
| starlette | 0.14.2 |
| starlette | 0.16.0 |
| statsd | 3.3.0 |
| statsmodels | 0.12.2 |
| statsmodels | 0.13.0rc0 |
| stdlib-list | 0.8.0 |
| stevedore | 3.4.0 |
| stomper | 0.4.3 |
| stone | 3.2.1 |
| streamlit | 0.88.0 |
| strict-rfc3339 | 0.7 |
| stringcase | 1.2.0 |
| stripe | 2.60.0 |
| structlog | 21.1.0 |
| subprocess32 | 3.5.4 |
| suds-jurko | 0.6 |
| superqt | 0.2.4 |
| supervisor | 4.2.2 |
| svgwrite | 1.4.1 |
| swagger-ui-bundle | 0.0.8 |
| symengine | 0.8.1 |
| sympy | 1.8 |
| tables | 3.6.1 |
| tablib | 3.0.0 |
| tabulate | 0.8.9 |
| tblib | 1.7.0 |
| telepath | 0.2 |
| telethon | 1.23.0 |
| tempita | 0.5.2 |
| tempora | 4.1.1 |
| tempstorage | 5.2 |
| tenacity | 6.2.0 |
| tenacity | 6.3.1 |
| tenacity | 8.0.1 |
| tensorboard | 2.6.0 |
| tensorboard-data-server | 0.6.1 |
| tensorboard-plugin-wit | 1.8.0 |
| tensorboardx | 2.4 |
| tensorflow | 2.6.0 |
| tensorflow-addons | 0.14.0 |
| tensorflow-datasets | 4.4.0 |
| tensorflow-estimator | 2.6.0 |
| tensorflow-gpu | 2.6.0 |
| tensorflow-hub | 0.12.0 |
| tensorflow-metadata | 1.2.0 |
| tensorflow-probability | 0.13.0 |
| termcolor | 1.1.0 |
| terminado | 0.12.1 |
| terminaltables | 3.1.0 |
| testfixtures | 6.18.1 |
| testpath | 0.5.0 |
| testresources | 2.0.1 |
| testscenarios | 0.5.0 |
| testtools | 2.5.0 |
| textblob | 0.15.3 |
| textrazor | 1.4.0 |
| texttable | 1.6.4 |
| text-unidecode | 1.3 |
| textwrap3 | 0.9.2 |
| the | 0.1.5 |
| theano | 1.0.5 |
| theano-pymc | 1.1.2 |
| therapist | 2.2.0 |
| thinc | 8.0.10 |
| thop | 0.0.31-2005241907 |
| threadpoolctl | 2.2.0 |
| thrift | 0.13.0 |
| tifffile | 2020.9.3 |
| tifffile | 2021.8.30 |
| timeout-decorator | 0.5.0 |
| timestamp | 0.0.1 |
| tinycss2 | 1.1.0 |
| tinydb | 4.5.1 |
| tldextract | 3.1.2 |
| tlslite-ng | 0.7.6 |
| tls-parser | 1.2.2 |
| tokenizers | 0.10.3 |
| toml | 0.10.2 |
| tomli | 1.2.1 |
| tomlkit | 0.7.2 |
| toolz | 0.11.1 |
| toposort | 1.6 |
| torch | 1.7.0 |
| torch | 1.9.0 |
| torchaudio | 0.9.0 |
| torchmetrics | 0.5.1 |
| torchtext | 0.10.0 |
| torchvision | 0.10.0 |
| torchvision | 0.8.1 |
| tornado | 6.1 |
| torthrift | 0.2.4 |
| towncrier | 21.3.0 |
| tox | 3.24.3 |
| tqdm | 4.62.2 |
| trac | 1.4.3 |
| traceback2 | 1.4.0 |
| tracers | 21.8.6876 |
| traitlets | 4.3.3 |
| traitlets | 5.1.0 |
| trans | 2.1.0 |
| transaction | 3.0.1 |
| transformers | 4.10.0 |
| transformers | 4.10.2 |
| transitions | 0.8.9 |
| translationstring | 1.4 |
| tree-sitter | 0.19.0 |
| treq | 21.5.0 |
| trimesh | 3.9.30 |
| trio | 0.19.0 |
| troposphere | 3.0.3 |
| trytond | 6.0.6 |
| trytond | 6.0.7 |
| trytond-account | 6.0.3 |
| trytond-company | 6.0.4 |
| trytond-country | 6.0.1 |
| trytond-currency | 6.0.1 |
| trytond-party | 6.0.2 |
| trytond-product | 6.0.2 |
| tskit | 0.3.7 |
| tweedledum | 1.1.1 |
| tweepy | 3.10.0 |
| twilio | 6.63.1 |
| twine | 3.4.2 |
| twisted | 21.2.0 |
| twisted | 21.7.0 |
| twisted-iocpsupport | 1.0.2 |
| txaio | 21.2.1 |
| typed-ast | 1.4.3 |
| typeguard | 2.12.1 |
| typer | 0.3.2 |
| typer | 0.4.0 |
| types-pyyaml | 5.4.10 |
| types-requests | 2.25.6 |
| typing | 3.7.4.3 |
| typing-compat | 0.1.0 |
| typing-extensions | 3.10.0.1 |
| typing-extensions | 3.10.0.2 |
| typing-extensions | 3.7.4.3 |
| typing-inspect | 0.7.1 |
| tzdata | 2021.1 |
| tzlocal | 2.1 |
| tzlocal | 3.0 |
| ujson | 4.1.0 |
| umap-learn | 0.5.1 |
| uncertainties | 3.1.6 |
| unicodecsv | 0.14.1 |
| unidecode | 1.3.1 |
| unidecode | 1.3.2 |
| unipath | 1.1 |
| unittest2 | 1.1.0 |
| uproot | 4.1.2 |
| uritemplate | 3.0.1 |
| urllib3 | 1.25.11 |
| urllib3 | 1.26.6 |
| url-normalize | 1.4.3 |
| urwid | 2.1.2 |
| uuid | 1.30 |
| uvicorn | 0.15.0 |
| uvloop | 0.16.0 |
| uwsgi | 2.0.19.1 |
| validate-docbr | 1.8.2 |
| validate-email | 1.3 |
| validators | 0.18.2 |
| varint | 1.0.2 |
| vcrpy | 4.1.1 |
| venusian | 3.0.0 |
| versioneer | 0.20 |
| vine | 1.3.0 |
| vine | 5.0.0 |
| virtualenv | 20.7.2 |
| virtualenv | 20.8.0 |
| virtualenv-clone | 0.5.7 |
| visitor | 0.1.3 |
| vispy | 0.8.1 |
| vobject | 0.9.6.1 |
| voluptuous | 0.12.1 |
| vtk | 9.0.3 |
| w3lib | 1.22.0 |
| wagtail | 2.14.1 |
| waitress | 2.0.0 |
| wand | 0.6.7 |
| wandb | 0.12.2 |
| warlock | 1.3.3 |
| wasabi | 0.8.2 |
| watchdog | 2.1.5 |
| watchgod | 0.7 |
| watchtower | 1.0.6 |
| wcwidth | 0.2.5 |
| weasyprint | 53.3 |
| webargs | 5.5.3 |
| webassets | 2.0 |
| webcolors | 1.11.1 |
| webdriver-manager | 3.4.2 |
| webencodings | 0.5.1 |
| webob | 1.8.7 |
| websocket-client | 0.59.0 |
| websocket-client | 1.2.1 |
| websockets | 10.0 |
| websockets | 8.0.2 |
| websockets | 9.1 |
| webstack-django-sorting | 2.0.2 |
| webtest | 3.0.0 |
| werkzeug | 1.0.1 |
| werkzeug | 2.0.1 |
| wget | 3.2 |
| wheel | 0.37.0 |
| whitenoise | 5.3.0 |
| whoosh | 2.7.4 |
| widgetsnbextension | 3.5.1 |
| wikipedia | 1.4.0 |
| willow | 1.4 |
| win32-setctime | 1.0.3 |
| win-inet-pton | 1.1.0 |
| wmctrl | 0.4 |
| wordcloud | 1.8.1 |
| wordsegment | 1.3.1 |
| wrapt | 1.12.1 |
| ws4py | 0.5.1 |
| wsgiproxy2 | 0.5.1 |
| wslink | 1.0.7 |
| wtforms | 2.3.3 |
| wxpython | 4.1.1 |
| x256 | 0.0.3 |
| xarray | 0.19.0 |
| xdg | 5.1.1 |
| xgboost | 1.4.2 |
| xlrd | 1.2.0 |
| xlrd | 2.0.1 |
| xlsxwriter | 1.4.5 |
| xlsxwriter | 3.0.1 |
| xlwt | 1.3.0 |
| xmlrpc2 | 0.3.1 |
| xmltodict | 0.12.0 |
| xxhash | 2.0.2 |
| yamllint | 1.26.3 |
| yapf | 0.31.0 |
| yappi | 1.3.2 |
| yarl | 1.6.3 |
| yaspin | 1.5.0 |
| yaspin | 2.1.0 |
| yfinance | 0.1.63 |
| youtube-dl | 2021.6.6 |
| z3c-autoinclude | 0.4.1 |
| z3c-caching | 2.2 |
| z3c-form | 4.2 |
| z3c-formwidget-query | 0.17 |
| z3c-jbot | 1.1.1 |
| z3c-objpath | 1.2 |
| z3c-pt | 3.3.0 |
| z3c-relationfield | 0.9.0 |
| z3c-zcmlhook | 1.1 |
| zarr | 2.9.5 |
| zc-buildout | 2.13.4 |
| zc-lockfile | 2.0 |
| zconfig | 3.6.0 |
| zc-relation | 1.1.post2 |
| zdaemon | 4.3 |
| zeep | 4.1.0 |
| zenpy | 2.0.24 |
| zeo | 5.2.3 |
| zeroconf | 0.36.4 |
| zeroconf | 0.36.5 |
| zexceptions | 4.1 |
| zict | 2.0.0 |
| zipp | 3.5.0 |
| zmq | 0.0.0 |
| zodb | 5.6.0 |
| zodb3 | 3.11.0 |
| zodbpickle | 2.0.0 |
| zope | 5.3 |
| zope2 | 4.0 |
| zope-annotation | 4.7.0 |
| zope-app-locales | 4.1 |
| zope-browser | 2.3 |
| zope-browsermenu | 4.4 |
| zope-browserpage | 4.4.0 |
| zope-browserresource | 4.4 |
| zope-cachedescriptors | 4.3.1 |
| zope-component | 5.0.1 |
| zope-componentvocabulary | 2.2.0 |
| zope-configuration | 4.4.0 |
| zope-container | 4.4.0 |
| zope-contentprovider | 4.2.1 |
| zope-contenttype | 4.5.0 |
| zope-copy | 4.2 |
| zope-datetime | 4.3.0 |
| zope-deferredimport | 4.3.1 |
| zope-deprecation | 4.4.0 |
| zope-dottedname | 4.3 |
| zope-event | 4.5.0 |
| zope-exceptions | 4.4 |
| zope-filerepresentation | 5.0.0 |
| zope-globalrequest | 1.5 |
| zope-hookable | 5.1.0 |
| zope-i18n | 4.8.0 |
| zope-i18nmessageid | 5.0.1 |
| zope-interface | 5.4.0 |
| zope-intid | 4.4.0 |
| zope-keyreference | 4.2.0 |
| zope-lifecycleevent | 4.3 |
| zope-location | 4.2 |
| zope-pagetemplate | 4.5.0 |
| zope-processlifetime | 2.3.0 |
| zope-proxy | 4.4.0 |
| zope-ptresource | 4.2.0 |
| zope-publisher | 6.0.2 |
| zope-ramcache | 2.3 |
| zope-schema | 6.1.0 |
| zope-security | 5.1.1 |
| zope-sendmail | 5.2 |
| zope-sequencesort | 4.1.2 |
| zope-site | 4.5.0 |
| zope-size | 4.3 |
| zope-sqlalchemy | 1.6 |
| zope-structuredtext | 4.3 |
| zope-tal | 4.5 |
| zope-tales | 5.1 |
| zope-testbrowser | 5.5.1 |
| zope-testing | 4.9 |
| zope-testrunner | 5.3.0 |
| zope-traversing | 4.4.1 |
| zope-viewlet | 4.2.1 |
| zopfli | 0.1.8 |
| zstandard | 0.15.2 |

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
  nixpkgs = import <nixpkgs> { };

  pythonOnNix = import (nixpkgs.fetchFromGitHub {
    owner = "kamadorueda";
    repo = "python-on-nix";
    # Pick a commit from this list:
    # https://github.com/kamadorueda/python-on-nix/commits/main
    rev = "0000000000000000000000000000000000000000";
    # Update this manually
    sha256 = "0000000000000000000000000000000000000000000000000000";
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

---

[NIX]: https://nixos.org/
[PYPI]: https://pypi.org/
[PYTHON]: https://www.python.org/
[PYTHON_RELEASES]: https://www.python.org/downloads/
[PYTHON_WHEELS]: https://pythonwheels.com/
