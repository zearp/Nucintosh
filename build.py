import plistlib
import shutil
import os

if os.path.exists('target'):
  shutil.rmtree('target')
shutil.copytree('EFI', 'target/EFI')

PLIST_CONFIG = 'target/EFI/OC/config.plist'

# 读取配置文件
config = {}
if not os.path.exists('./config'):
  raise FileNotFoundError(f"The configuration file './config' does not exist.")
with open('./config', 'r') as file:
  for line in file:
    key, value = line.strip().split('=')
    config[key] = value

# 读取XML文件
with open(PLIST_CONFIG, 'rb') as f:
    plist_data = plistlib.load(f, fmt=plistlib.FMT_XML)

# 设置SMBIOS
plist_data['PlatformInfo']['Generic']['MLB'] = config['MLB']
plist_data['PlatformInfo']['Generic']['ROM'] = config['ROM']
plist_data['PlatformInfo']['Generic']['SystemSerialNumber'] = config['SYSTEM_SERIAL_NUMBER']
plist_data['PlatformInfo']['Generic']['SystemUUID'] = config['SYSTEM_UUID']

# 设置UIScale的值
plist_data['UEFI']['Output']['UIScale'] = int(config['UI_SCALE'])

# 设置boot-args的值
plist_data['NVRAM']['Add']['7C436110-AB2A-4BBB-A880-FE41995C9F82']['boot-args'] = 'keepsyms=1'

# 保存更新后的XML文件
with open(PLIST_CONFIG, 'wb') as f:
    plistlib.dump(plist_data, f, fmt=plistlib.FMT_XML)