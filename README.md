# Open Accession Agreement

an open form contract for paid conversion of private software to open source

Developer has proprietary code, say a [License Zero](https://licensezero.com) project.  Sponsor pays developer.  Developer relicenses under a pre-agreed Open Source license and publishes.

Download the most recent release from [GitHub](https://github.com/licensezero/accession-agreement/releases) or [commonform.org](https://commonform.org/publishers/licensezero/accession-agreement).

## Be Warned!

**Contracts are prescription-strength legal devices.  If you need terms for a software deal, don't be an idiot.  Hire a lawyer.  A good one will ask good questions. They may decide this form fits your needs.**

**Do _not_ put confidential information about you, your work, or your clients in issues or pull requests.  Do _not_ ask for legal advice on GitHub, or try to disguise requests for legal advice as general questions or hypotheticals.  You don't want advice from anybody dumb enough to fall for that.**

## In Brief

The License Zero Open Accession Agreement is a form contract for the paid relicensing of software onto Open Source terms.

## Building

The repository has configuration to build copies of the terms in various formats, including Word, PDF, Markdown, and native Common Form.

If you're alright agreeing to the terms of use for Microsoft's Core Fonts for the Web, for Times New Roman, the easiest way to build is probably with Docker:

```shellsession
git clone https://github.com/licensezero/open-accession-agreement
cd open-accession-agreement
git checkout $edition
make docker
```

The `Dockerfile` uses a Debian Linux base image for Node.js, and installs other build tools from Debian package repositories.  If you want to build without Docker, have a look at the `RUN` lines in `Dockerfile` to see what you'll need.

## Thanks

The License Zero Open Accession Agreement can only improve and succeed with the help of community members---lawyers, coders, and businesspeople---who take time to share their thoughts and experiences.
