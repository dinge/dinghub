

OPTIONAL MATCH (concept:`Maker::Concept`)-[r:`instance_of`]-(items:`Maker::Item`)
OPTIONAL MATCH (concept:`Maker::Concept`)-[r:`contains`]-(bundles:`Maker::Bundle`)
WHERE ID(concept) = 8
RETURN concept, items, bundles