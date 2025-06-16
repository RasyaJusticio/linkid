<div class="amounts-template w-100 mt-3">
    {if $view == "topup"}
      <button type="button" class="col btn btn-primary" data-amount="10000">10K</button>
      <button type="button" class="col btn btn-primary" data-amount="20000">20K</button>
      <button type="button" class="col btn btn-primary" data-amount="50000">50K</button>
      <button type="button" class="col btn btn-primary" data-amount="100000">100K</button>

      <button type="button" class="col btn btn-primary" data-amount="200000">200K</button>
      <button type="button" class="col btn btn-primary" data-amount="300000">300K</button>
      <button type="button" class="col btn btn-primary" data-amount="500000">500K</button>
      <button type="button" class="col btn btn-primary" data-amount="750000">750K</button>

      <button type="button" class="col btn btn-primary" data-amount="1000000">1 JT</button>
      <button type="button" class="col btn btn-primary" data-amount="2000000">2 JT</button>
      <button type="button" class="col btn btn-primary" data-amount="3000000">3 JT</button>
      <button type="button" class="col btn btn-primary" data-amount="4000000">4 JT</button>
    {elseif $view == "withdraw"}
      <button type="button" class="col btn btn-primary" data-amount="50000">50K</button>
      <button type="button" class="col btn btn-primary" data-amount="100000">100K</button>
      <button type="button" class="col btn btn-primary" data-amount="200000">200K</button>
      <button type="button" class="col btn btn-primary" data-amount="300000">300K</button>

      <button type="button" class="col btn btn-primary" data-amount="400000">400K</button>
      <button type="button" class="col btn btn-primary" data-amount="500000">500K</button>
      <button type="button" class="col btn btn-primary" data-amount="600000">600K</button>
      <button type="button" class="col btn btn-primary" data-amount="750000">750K</button>

      <button type="button" class="col btn btn-primary" data-amount="1000000">1 JT</button>
      <button type="button" class="col btn btn-primary" data-amount="2000000">2 JT</button>
      <button type="button" class="col btn btn-primary" data-amount="3000000">3 JT</button>

      {if !empty($balance)}
        <button type="button" class="col btn btn-primary" data-amount="{$balance}">=</button>
      {else}
        <button type="button" class="col btn btn-primary" data-amount="4000000">4 JT</button>
      {/if}
    {else}
      <button type="button" class="col btn btn-primary" data-amount="500">500</button>
      <button type="button" class="col btn btn-primary" data-amount="1000">1K</button>
      <button type="button" class="col btn btn-primary" data-amount="2000">2K</button>
      <button type="button" class="col btn btn-primary" data-amount="5000">5K</button>

      <button type="button" class="col btn btn-primary" data-amount="10000">10K</button>
      <button type="button" class="col btn btn-primary" data-amount="15000">15K</button>
      <button type="button" class="col btn btn-primary" data-amount="20000">20K</button>
      <button type="button" class="col btn btn-primary" data-amount="30000">30K</button>

      <button type="button" class="col btn btn-primary" data-amount="50000">50K</button>
      <button type="button" class="col btn btn-primary" data-amount="75000">75K</button>
      <button type="button" class="col btn btn-primary" data-amount="100000">100K</button>
      <button type="button" class="col btn btn-primary" data-amount="200000">200K</button>
    {/if}
</div>
