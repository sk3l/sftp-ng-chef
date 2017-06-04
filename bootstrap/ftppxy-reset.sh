#!/bin/bash

NODE=ftppxy
CLIENT=ftppxy

knife node delete $NODE -y
knife client delete $NODE -y
