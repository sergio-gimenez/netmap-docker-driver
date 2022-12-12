#!/usr/bin/env python3

import lib.NetworkDriver
# inport logging
import os

import docker_plugin_api.Plugin
import flask
import waitress
import subprocess

# subprocess.Popen(["modprobe", "netmap"])

app = flask.Flask('vale')
# app.logger.setLevel(logging.DEBUG)

app.register_blueprint(docker_plugin_api.Plugin.app)

docker_plugin_api.Plugin.functions.append('NetworkDriver')
app.register_blueprint(lib.NetworkDriver.app)

if __name__ == '__main__':
    if os.environ.get('ENVIRONMENT', 'dev') == 'dev':
        app.run(debug=True)
    else:
        waitress.serve(
            app, unix_socket='/run/docker/plugins/vale.sock', threads=1)
