Docker Pandoc Image
===================

[![pipeline status](https://gitlab.com/jwhb/docker-pandoc/badges/main/pipeline.svg)](https://gitlab.com/jwhb/docker-pandoc/-/commits/main)

This repository produces the following artifacts:

* **Pandoc image**, based on Fedora 35, LaTeX base environment pre-installed.
* **Eisvogel image**, based on Pandoc image, [Eisvogel template](https://github.com/Wandmalfarbe/pandoc-latex-template) and additional LaTeX packages pre-installed.
* **Pandoc RPM**, for x86\_64 rpm-based Linux systems.


Usage
-----

Install a container runtime, e.g. [Docker](https://www.docker.com/products/docker-desktop) or [Podman](https://podman.io/).
The following usage examples assume that Docker is installed.

### Run Pandoc base image
To produce `output.pdf` from `input.md`:
```bash
docker run --rm -v $PWD:/source -w /source -it registry.gitlab.com/jwhb/docker-pandoc:latest pandoc input.md -o output.pdf
```

### Run Pandoc Eisvogel image
To produce `output.pdf` from `input.md` with Eisvogel template:
```bash
docker run --rm -v $PWD:/source -w /source -it registry.gitlab.com/jwhb/docker-pandoc:eisvogel pandoc --template=eisvogel input.md -o output.pdf
```

### Use the RPM package
The RPM can be installed on x86\_64 rpm-based Linux systems.


Build this image
----------------

To build this image yourself, clone the repository and execute:
```bash
# for pandoc image
docker build --build-arg PANDOC_VERSION="2.14" -t local/pandoc .

# for eisvogel image
docker build --build-arg PANDOC_VERSION="2.14" -t local/eisvogel ./eisvogel
```

