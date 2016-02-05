import os
import shutil
import subprocess

print "=================================="
print "|  Simply Knock Release Builder  |"
print "|           __________           |"
print "|          |  __  __  |          |"
print "|          | |  ||  | |          |"
print "|          | |  ||  | |          |"
print "|          | |__||__| |          |"
print "|          |  __  __()|          |"
print "|          | |  ||  | |          |"
print "|          | |  ||  | |          |"
print "|          | |__||__| |          |"
print "|          |__________|          |"
print "=================================="


user_input = raw_input("Enter the release version: ")

os.chdir("..\\")

# Build the temp directory
print "Creating temp directories..."
tempdir = ".\\tmp\\Data\\"
os.makedirs('./tmp/Data/readmes')
os.makedirs('./tmp/Data/Interface/simplyknock')
os.makedirs('./tmp/Data/Interface/Translations')
os.makedirs('./tmp/Data/Scripts/Source')
os.makedirs('./tmp/Data/SEQ')
os.makedirs('./tmp/Data/sound/fx')

# Copy the project files
print "Copying project files..."
with open("./Simply Knock/SimplyKnockArchiveManifest.txt") as manifest:
    lines = manifest.readlines()
    for line in lines:
        shutil.copy(".\\SimplyKnock\\" + line.rstrip('\n'), tempdir + line.rstrip('\n'))

# Build the directories
dirname = "./Simply Knock " + user_input + " Release"
if not os.path.isdir(dirname):
    print "Creating new build..."
    os.mkdir(dirname)
else:
    print "Removing old build of same version..."
    shutil.rmtree(dirname)
    os.mkdir(dirname)

os.mkdir(dirname + "/readmes")
os.makedirs(dirname + "/SKSE/Plugins")

# Generate BSA archive
print "Generating BSA archive..."
shutil.copy('./SimplyKnock/Archive.exe', './tmp/Archive.exe')
shutil.copy('./SimplyKnock/SimplyKnockArchiveBuilder.txt', './tmp/SimplyKnockArchiveBuilder.txt')
shutil.copy('./SimplyKnock/SimplyKnockArchiveManifest.txt', './tmp/SimplyKnockArchiveManifest.txt')
os.chdir("./tmp")
subprocess.call(['./Archive.exe', './CampfireArchiveBuilder.txt'])
os.chdir("..\\")

# Copy files
shutil.copyfile("./SimplyKnock/SimplyKnock.esp", dirname + "/SimplyKnock.esp")
shutil.copyfile("./tmp/SimplyKnock.bsa", dirname + "/SimplyKnock.bsa")
shutil.copyfile("./SimplyKnock/SKSE/Plugins/simplyknock.dll", dirname + "/SKSE/Plugins/simplyknock.dll")
shutil.copyfile("./SimplyKnock/SKSE/Plugins/StorageUtil.dll", dirname + "/SKSE/Plugins/StorageUtil.dll")
shutil.copyfile("./SimplyKnock/readmes/SimplyKnock_readme.txt", dirname + "/readmes/SimplyKnock_readme.txt")
shutil.copyfile("./SimplyKnock/readmes/SimplyKnock_license.txt", dirname + "/readmes/SimplyKnock_license.txt")

# Clean Up
print "Removing temp files..."
shutil.rmtree("./tmp")

# Create release zip
zip_name_ver = user_input.replace(".", "_")
shutil.make_archive("./SimplyKnock_" + zip_name_ver + "_Release", format="zip", root_dir=dirname)
shutil.move("./SimplyKnock_" + zip_name_ver + "_Release.zip", dirname + "/SimplyKnock_" + zip_name_ver + "_Release.zip")
print "Created " + dirname + "/SimplyKnock_" + zip_name_ver + "_Release.zip"
print "Done!"
