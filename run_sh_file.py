import subprocess
import datetime
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("--wk", type=str, default="worker-default")
args = parser.parse_args()

wk_name = args.wk


subprocess.call(['sh', './run_xrmig.sh', '&'])

subprocess.call(['sh', './run.sh',  wk_name])

