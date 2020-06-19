#!/bin/bash
docker-compose down && docker-compose pull && docker-compose build --no-cache && docker-compose up -d
