#!/usr/bin/python

from pyquery import PyQuery as pq
import json

SITE_ROOT = 'https://developer.nulab-inc.com'
API_ROOT = SITE_ROOT + '/docs/typetalk/'

top = pq(url=API_ROOT)
for i in top('span.field-content > a'):
    path = i.get('href')
    if path.find('/docs/typetalk/api/1/') != 0: continue

    name = path.split('/')[-1]
    print(name)
    output_name = 'api_' + name + '.json'
    with file(output_name, 'w') as f:
        data = pq(url=SITE_ROOT + path)
        response = data('pre.highlight').text()
        if response == '':
            response = '{}'
        f.write(response)

        try:
            json.loads(response)
        except:
            print('WARNING:' + output_name + ' is not valid JSON.')
            pass
