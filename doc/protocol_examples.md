<p>
 Both
 <span itemscope="" itemtype="http://microformats.org/profile/hcard" itemref="home">
   <span itemprop="fn">
     <span itemprop="n" itemscope="">
     <span itemprop="given-name">Princeton</span></span>
   </span>
  </span>
 and
 <span itemscope="" itemtype="http://microformats.org/profile/hcard" itemref="home">
   <span itemprop="fn"><span itemprop="n" itemscope="">
   <span itemprop="given-name">Trekkie</span></span></span>
  </span>
 live at
 <span id="home" itemprop="adr" itemscope="">
   <span itemprop="street-address">Avenue Q</span>.
 </span>
</p>



<div class="connector cardtec_tunnel" itemscope="" itemid="09746523-9df4-4b3a-8280-4a74edb88146" itemtype='http://schema.org/Thing'>
  <div class="first_node">
    <h4 itemprop="name">Bagger</h4>
  </div>
  <div class="new_connected_relationship"><button class="large relationship_type active">produces</button></div>
  <div class="last_node" itemscope='' itemid="4ab01305-ba4c-40d4-9453-9fe0d5afeb39" itemprop="isRelatedTo">
    <h4 temprop="name">
      Baby
    </h4>
  </div>
</div>



<p>
 Both
 <span itemscope="" itemtype="http://microformats.org/profile/hcard" itemref="home">
   <span itemprop="fn">
     <span itemprop="n" itemscope="">
     <span itemprop="given-name">Princeton</span></span>
   </span>
  </span>
 and
 <span itemscope="" itemtype="http://microformats.org/profile/hcard" itemref="home">
   <span itemprop="fn"><span itemprop="n" itemscope="">
   <span itemprop="given-name">Trekkie</span></span></span>
  </span>
 live at
 <span id="home" itemprop="adr" itemscope="">
   <span itemprop="street-address">Avenue Q</span>.
 </span>
</p>




b = %Q|
<p>
 Both
 <span itemscope="" itemtype="http://microformats.org/profile/hcard" itemref="home">
   <span itemprop="fn">
     <span itemprop="n" itemscope="">
     <span itemprop="given-name">Princeton</span></span>
   </span>
  </span>
 and
 <span itemscope="" itemtype="http://microformats.org/profile/hcard" itemref="home">
   <span itemprop="fn"><span itemprop="n" itemscope="">
   <span itemprop="given-name">Trekkie</span></span></span>
  </span>
 live at
 <span id="home" itemprop="adr" itemscope="">
   <span itemprop="street-address">Avenue Q</span>.
 </span>
</p>|
docb1 = Mida::Document.new(b)
docb1.items




<div class="connector cardtec_tunnel" itemscope='' itemtype='http://dingdealer.de/Statement'>
  <div class="first_node" itemprop="subject" itemscope='' itemid="09746523-9df4-4b3a-8280-4a74edb88146" itemtype='http://dingdealer.de/maker/concept'>
    <h4 itemprop="title">Apfel</h4>
  </div>
  <div class="new_connected_relationship" itemprop='predicate' itemscope='' itemtype='http://dingdealer.de/maker/relationship'>
    <button class="large relationship_type active" itemprop="title">is_a</button>
  </div>
  <div class="last_node" itemprop="object" itemscope='' itemid="4ab01305-ba4c-40d4-9453-9fe0d5afeb39" itemtype='http://dingdealer.de/maker/concept'>
    <h4 itemprop="title">Obst</h4>
  </div>
</div>


