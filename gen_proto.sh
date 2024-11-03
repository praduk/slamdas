#!/bin/bash
protoc --proto_path=lib/src --dart_out=lib/src data.proto
