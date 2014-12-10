

MATCH (concept:`Maker::Concept`)
OPTIONAL MATCH (concept)-[r:`instance_of`]-(items:`Maker::Item`)
OPTIONAL MATCH (concept)-[r:`contains`]-(bundles:`Maker::Bundle`)
OPTIONAL MATCH (concept)-[r:`has_property`]-(traits:`Maker::Trait`)
WHERE ID(concept) = 8
RETURN concept, items, bundles, traits


OPTIONAL MATCH (concept:`Maker::Concept`)--(related_nodes)
WHERE ID(concept) = 8
RETURN concept, related_nodes


