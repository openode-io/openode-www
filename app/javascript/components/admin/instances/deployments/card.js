export default {
  name: 'DeploymentCard',

  props: {
    deployment: Object,
    instance: Object
  },

  render () {
    return (
      <div class='col-lg-12 col-sm-6 mb-2'>
        <div class={`card card-instance-details border-${this.deployment.status.level}`}>
          <div class='card-body'>
            <div class="row">
              <div class='col-lg-4 col-sm-4'>
                <i class="fa fa-globe-americas"></i> {this.deployment.site_name || "No Site Name Added"}
              </div>
              <div class='col-lg-6 col-sm-6'>
                <span class={`badge badge-${this.deployment.status.level}`}>
                  {`${this.deployment.status.message}`}
                </span>
              </div>
              <div class='col-lg-2 col-sm-2text-right'>
                <i class="fa fa-calendar" /> {`${this.deployment.date}`}
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }
}