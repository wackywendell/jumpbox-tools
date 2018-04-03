import sys

lines = [l.strip() for l in sys.stdin if l.strip()]

rix = lines.index('Roles:')
tix = lines.index('Tags:')

roles = lines[rix+1:tix]
all_tags = lines[tix+1:-1]

ignored_roles = set(['common-node', 'monitoring-client', 'dog-base', 'encrypted-storage'])
roles = [r for r in roles if r not in ignored_roles]

ignored_groups = 'Instance Type', 'AZ'
kafka_tags = {}
tags = []
for tag in all_tags:
    g, sep, val = tag.partition(':')
    if not sep:
        tags.append(g)
        continue

    if g in ignored_groups:
        continue
    if g.startswith('kafka_') or g == 'zk_cluster':
        kafka_tags.setdefault(g, []).append(val)
        continue
    tags.append(tag)

kafka_string = ''
cluster_tags = kafka_tags.get('kafka_cluster', [])
if len(cluster_tags) == 1:
    cluster = cluster_tags[0]
    if cluster.startswith('kafka-'):
        cluster = cluster[6:]
    topic = '|'.join(kafka_tags.get('kafka_topic', []))
    partitions = '|'.join(kafka_tags.get('kafka_partition', []))
    kafka_string = 'kafka:%s/%s/%s' % (cluster, topic, partitions)

out = ','.join(roles + tags)
if kafka_string:
    out = out + ' ' + kafka_string

print out