<div class="card-header with-icon">
  {if in_array($sub_view, ['add', 'edit'])}
  <div class="float-end">
    <a href="{$org_url}/bills" class="btn btn-md btn-light">
      <i class="fa fa-arrow-circle-left"></i><span class="ml5 d-none d-lg-inline-block">{__("Go Back")}</span>
    </a>
  </div>
  {/if}
  <i class="fa fa-credit-card fa-lg fa-fw mr10"></i>{__("Bills")}
</div>

{if $sub_view == ""}

<div class="card-body">
  {if $bill_pay_amount}
  <div class="alert alert-success mb20">
    <i class="fas fa-check-circle mr5"></i>
    {__("Your")} <span class="badge rounded-pill badge-lg bg-secondary">{print_money($bill_pay_amount|format_number)}</span> {__(" bill payment successfuly sent")}
  </div>
  {/if}
  <div class="table-responsive">
    <table class="table table-striped table-bordered table-hover js_datatable">
      <thead>
        <tr>
          <th>{__("ID")}</th>
          <th>{__("Amount")}</th>
          <th>{__("Description")}</th>
          <th>{__("Due Date")}</th>
          <th>{__("Status")}</th>
          <th>{__("Actions")}</th>
        </tr>
      </thead>
      <tbody>
        {if $rows}
        {foreach $rows as $row}
        <tr>
          <td>
            {$row['id']}
          </td>
          <td>
            {print_money($row['paid']|format_number)} / {print_money($row['amount']|format_number)}
          </td>
          <td>
            {$row['description']}
          </td>
          <td>{$row['due_date']|date_format:"%e %B %Y"}</td>
          <td>
            {if $row['status'] == "paid"}
            <span class="badge rounded-pill badge-lg bg-success">{__("Paid")}</span>
            {elseif $row['status'] == "unpaid"}
            <span class="badge rounded-pill badge-lg bg-gradient-gray">{__("Unpaid")}</span>
            {elseif $row['status'] == "overdue"}
            <span class="badge rounded-pill badge-lg bg-danger">{__("Overdue")}</span>
            {/if}
          </td>
          <td>
            <button data-bs-toggle="tooltip" title='{__("Pay")}' class="btn btn-sm btn-icon btn-rounded btn-primary" data-toggle="modal" data-url="#org-bill-pay" data-options='{ "org_id": {$organization['id']}, "bill_id": {$row['id']}, "bill_amount": {$row['amount']} }'>
              <i class="fa fa-credit-card"></i>
            </button>
          </td>
        </tr>
        {/foreach}
        {else}
        <tr>
          <td colspan="7" class="text-center">
            {__("No data to show")}
          </td>
        </tr>
        {/if}
      </tbody>
    </table>
  </div>
</div>

{/if}
