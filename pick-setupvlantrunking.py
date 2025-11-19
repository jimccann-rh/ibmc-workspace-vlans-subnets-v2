import SoftLayer
import json
import os

from SoftLayer import VSManager, Client, NetworkManager,HardwareManager

# Set the username and API key
username = "apikey"
api_key = os.environ["IBMCLOUD_API_KEY"]

# Get the SoftLayer API client
client = SoftLayer.Client(username=username, api_key=api_key)

# Print the user's ID
print(SoftLayer.Client)
resp = client.call('Account', 'getObject')
print(resp['companyName'])

vs = VSManager(client)
#print(vs.list_instances())

#SoftLayer.managers.network.NetworkManager
network = NetworkManager(client)


#get input on project
project = input("Enter VLAN prefix value ex: ci_vlan_: ") 
project2 = input("Enter Hostname value: ") 
runit = input("Enter YES to do it: ") 

#data = network.list_vlans("ci_vlan_*")
data = network.list_vlans(name=project + "*")
#print(data)
print(data[0])
print(data[0]['id'])
print(data[0]['name'])

# Print the name of each VLAN
for i in data:
  print(i['name'])
  print(i['id'])
  print(i['vlanNumber'])
  networkvlanid = [{'id': i['id']}]
  hardware = HardwareManager(client)

  #data2 = hardware.list_hardware(hostname=project2 + "-vmware-host-*")
  data2 = hardware.list_hardware(hostname=project2)


  print(data2)
  #print(data2[0]['hostname'])

  if runit == ('YES'):
    print("DOIT")
    for j in data2:
      print(j['hostname'])
      print(j['id'])
      bmsid = j['id']
      data3 = hardware.get_hardware(hardware_id=bmsid)
#      print(data3)
      print(data3['networkComponents'])
      print(data3['networkComponents'][1])
      print(data3['networkComponents'][1]['id'])
      bmsnetworkid = data3['networkComponents'][1]['id']
      trunkVlan = client['SoftLayer_Network_Component'].addNetworkVlanTrunks(networkvlanid, id=bmsnetworkid)

