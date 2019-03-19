#tests --> CHANNELS

#0. make sure that what's being returned is in the format we want (i.e. a hash or array)

#1. make sure that what is returned are actual channels
# expect(channels.list) includes "general"

#2. make sure that the right things are being returned for each users
# expect { one component of generals's user info is } channel name
# expect { one component of generals's user info is } slack_id
# expect { one component of generals's user info is } topic
# expect { one component of generals's user info is } user count

#3. expect if there are NO channels -> return empty array
