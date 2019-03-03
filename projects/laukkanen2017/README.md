# Introduction

This repository contains the quantitative data used in the article [Towards continuous delivery by reducing the feature freeze period: a case study](https://www.researchgate.net/profile/Eero_Laukkanen/publication/313477142_Towards_Continuous_Delivery_by_Reducing_the_Feature_Freeze_Period_A_Case_Study/links/5a1a7cc94585155c26ac7190/Towards-Continuous-Delivery-by-Reducing-the-Feature-Freeze-Period-A-Case-Study.pdf) published at ICSE 2017.

# Contents

- `commits.csv`: commit data from git repositories (see the article for details)
	- `repository`: repository name
	- `timestamp`: timestamp when the commit was done
	- `branch`: whether the branch was in master branch or freeze branch (manually categorized, see the article for details)
	- `referenced_issue`: what type of issue was referenced in the commit message
		- `NULL`: no issue referenced
		- `DEV/AT/PS`: see issue types below
- `issues.csv`: issue data from JIRA (see the article for more details)
	- `resolved_timestamp`: timestamp when the issue was resolved
	- `type`: issue type
		- `DEV`: development task
		- `AT`: acceptance test issue
		- `PS`: production issue
- `releases.csv`: release dates from wiki pages
	- `name`: name of the release
	- `feature_freeze_date`: feature freeze date of the release
	- `production_deployment_date`: production deployment date of the release

# TODO

- Add scripts that draw the figures of the article
