Relationship Types:
===================

is_a
instance_of
part_of

is_property_of
subclass_of



some custom
-----------
annotates
defines
uses


-----------

has_child
has_silbing
derives_from



umls relationship types
------------------------
http://www.clres.com/semrels/umls_relation_list.html


consists_of       constitutes
contains          contained_in
location_of       has_location
method_of         has_method
part_of           has_part
performs          performed_by
produces          produced_by
property_of       has_property
result_of         has_result
uses              used_by



wikidata properties
-------------------
http://www.wikidata.org/wiki/Wikidata:List_of_properties/Summary_table
https://www.wikidata.org/wiki/Wikidata:List_of_properties/all_in_one_table

facet_of
proved_by
approved_by
use (function, role, mission, purpose)
followed_by
owned_by



playground / examples
----------------------

<!-- (actor) [contributed]   (contribution)  [contributed_to]   (thing) -->

(actor) [performs]      (contribution)  [produces]      (thing)
<!-- (actor) [performs]      (statement)     [constitutes]   (thing) -->
