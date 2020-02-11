export default {
  name: 'DeploymentCard',

  props: {
    deployment: Object,
    instance: Object
  },

  render () {
    return (
      <div class='col-lg-12 col-sm-6 mb-4'>
        <div class={`card card-instance-details border-${this.deployment.status.level}`}>
          <div class='card-header'>
            <div class='d-flex'>
              <h5 class='card-title flex-grow-1 m-0'>
                {this.instance.site_name}
              </h5>
            </div>
          </div>
          <div class='card-body'>
            <div class="row">
              <div class='col-lg-10 col-sm-10 mb-4'>
                <span class={`badge badge-${this.deployment.status.level}`}>
                  {`${this.deployment.status.message}`}
                </span>
              </div>
              <div class='col-lg-10 col-sm-10 mb-4'>
                <i class="fa fa-calendar" /> {`${this.deployment.date}`}
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }
}