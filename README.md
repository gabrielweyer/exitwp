# Exitwp

Exitwp is tool for making migration from one or more WordPress blogs to the [Jekyll blog engine][jekyll] as easy as possible.

By default it will try to convert as much information as possible from WordPress but can also be told to filter the amount of data it converts.

The latest version of these docs should always be available at [https://github.com/gabrielweyer/exitwp][exitwp-gw]. **This is a fork from [exitwp][exitwp] as the repository is not maintained anymore**.

- Discard drafts
- Generate output that can be directly pasted in your Jekyll blog
  - Images are downloaded by default and Markdown links are updated to reference them
- Remove support for importing multiple blogs at the same time

## Getting started

- Download [https://github.com/gabrielweyer/exitwp/zipball/master][zipball] or clone using `git clone https://github.com/gabrielweyer/exitwp.git`
- Export one or more WordPress blogs using the WordPress exporter under tools/export in WordPress admin
- Put all WordPress XML files in the `wordpress-xml` directory
- Special note for WordPress 3.1: you need to add a missing namespace in rss tag : `xmlns:atom="http://www.w3.org/2005/Atom"`
- Run the converter by typing `python exitwp.py` in the console from the directory of the unzipped archive
- You should now have all the blogs converted into separate directories under the `build` directory

## Runtime dependencies

- [Python][python] 2.6, 2.7, ???
- [html2text][html2text]: converts HTML to Markdown (Python)
- [PyYAML][py-yaml]: Reading configuration files and writing YAML headers (Python)
- [Beautiful soup][beautiful-soup]: Parsing and downloading of post images/attachments (Python)

### Installing dependencies in Ubuntu/Debian

```bash
sudo apt-get install python-yaml python-bs4 python-html2text
```

### Installing Python dependencies using Python package installer (pip)

From the checked out root for this project, type:

```bash
sudo pip install --upgrade -r pip_requirements.txt
```

Note that `PyYAML` will require other packages to compile correctly under Ubuntu/Debian, these are installed by typing:

```bash
sudo apt-get install libyaml-dev python-dev build-essential
```

### Using Vagrant for dependency management

In the event your local system is incompatible with the dependencies listed (or you'd rather not install them), you can use the included Vagrantfile to start a VM with all necessary dependencies installed.

1. Place all WordPress XML files in the `wordpress-xml` directory as mentioned above
1. In the directory of the unzipped archive, run `vagrant up`
1. `SSH` to your Vagrant VM using `vagrant ssh`
1. Run `cd /vagrant` to open the VM's shared folder
1. Run the converter from the VM by typing `python exitwp.py`
1. After the converter completes, exit the `SSH` session using `exit`
1. You should now have all the blogs converted into separate directories under the `build` directory
1. **Important**: Once satisfied with the results, run `vagrant destroy -f` to shut down the VM and remove the virtual drive from your local machine

## Run via Docker

### Build the Docker image

In this directory run:

```bash
docker build -t gabrielweyer/exitwp .
```

### Run

- `/exitwp/wordpress-xml` should be mapped to the directory containing your WordPress export
- `/exitwp/build` should be mapped to the directory where you wish to generate the Jekyll files

```posh
docker run --rm --volume E:\tmp\exitwp\wordpress-xml:/exitwp/wordpress-xml --volume E:\tmp\exitwp\build:/exitwp/build gabrielweyer/exitwp
```

## Configuration/Customization

See the [configuration file][configuration-file] for all configurable options.

Some things like custom handling of non standard post types is not fully configurable through the config file. You might have to modify the [source code][source-code] to add custom parsing behaviour.

## Known issues

- Target file names are some times less than optimal.
- Rewriting of image/attachment links if they are downloaded would be a good feature
- There will probably be issues when migrating non utf-8 encoded wordpress dump files (if they exist).

## Other Tools

- A [Gist][gist] to convert WP-Footnotes style footnotes to PHP Markdown Extra style footnotes

[jekyll]: https://github.com/jekyll/jekyll
[exitwp-gw]: https://github.com/thomasf/exitwp
[exitwp]: https://github.com/thomasf/exitwp
[zipball]: https://github.com/gabrielweyer/exitwp/zipball/master
[python]: https://www.python.org/
[html2text]: http://www.aaronsw.com/2002/html2text/
[py-yaml]: https://pyyaml.org/wiki/PyYAML
[beautiful-soup]: https://www.crummy.com/software/BeautifulSoup/
[configuration-file]: https://github.com/gabrielweyer/exitwp/blob/master/config.yaml
[source-code]: https://github.com/gabrielweyer/exitwp/blob/master/exitwp.py
[gist]: https://gist.github.com/1246047
