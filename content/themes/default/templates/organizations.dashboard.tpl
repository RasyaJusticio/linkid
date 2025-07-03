<div class="card">
  <div class="card-header with-icon">
    <i class="fa fa-tachometer-alt mr10"></i>{__("Dashboard")}
  </div>
  <div class="card-body">
    <div class="row">
      <div class="col-sm-6">
        <div class="stat-panel bg-gradient-primary">
          <div class="stat-cell narrow">
            <i class="fa fa-users bg-icon"></i>
            <span class="text-xxlg">{$insights['accounts']}</span><br>
            <span class="text-lg">{__("Accounts")}</span><br>
            <a href="{$system['system_url']}/organizations/sub-accounts">{__("Manage Accounts")}</a>
          </div>
        </div>
      </div>
      <div class="col-sm-6">
        <div class="stat-panel bg-gradient-teal">
          <div class="stat-cell narrow">
            <i class="fa fa-clock bg-icon"></i>
            <span class="text-xxlg">{print_money($insights['balance']|format_number)}</span><br>
            <span class="text-lg">{__("Balance")}</span><br>
            <a href="{$system['system_url']}/organizations">{__("Top Up")}</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
