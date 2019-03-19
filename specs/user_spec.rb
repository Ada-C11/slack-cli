# users:

#tests -->

#0. make sure that what's being returned is in the format we want (i.e. a hash or array)

#1. make sure that what is returned are actual users
# expect(users.list) includes Amy

#2. make sure that the right things are being returned for each users
# expect { one component of Amy's user info is } real name
# expect { one component of Amy's user info is } slack_id
# expect { one component of Amy's user info is } username

#3. expect if there are NO users -> return empty array
