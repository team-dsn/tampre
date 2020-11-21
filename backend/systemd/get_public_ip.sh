#!/bin/bash

ip_address=$(curl inet-ip.info)

export PUBLIC_IP=$ip_address
