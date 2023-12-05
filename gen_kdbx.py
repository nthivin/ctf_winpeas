import os
from pykeepass import PyKeePass, create_database

# remove existing file if it exists
if os.path.exists("pass.kdbx"):
    os.remove("pass.kdbx") 

# create database
kp = create_database('pass.kdbx', password = '5Mn]c4KE*Apy)98')

# create a new group
group = kp.add_group(kp.root_group, 'Employees')

# create a new entry
kp.add_entry(group, 'Employee', 'This is a prank', 'no_password')

# save database
kp.save()
