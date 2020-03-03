import axios from 'axios'

export default {
  name: 'New',

  props: {
    buttonText: String,
    buttonSize: String
  },

  data: function () {
    return {

      error: false,
      modalShow: false,
      form: {
        domain_type: 'subdomain',
        site_name: '',
        account_type: 'free',
        location: 'canada',
        open_source_description: '',
        open_source_repository: '',
        open_source_title: ''

      },
      plans: [],
      locations: [],
      domains: [],
      show: {
        form: true,
        custom_domain: false
      },
      button: {
        text: 'Create',
        disabled: false
      }
    }
  },

  mounted () {
    this.getLocations()
    this.getDomainTypes()
    this.getPlans()
  },

  methods: {
    showModal () {
      this.$refs.newInstanceModal.show()
    },

    onSubmit () {
      this.processing = true
      this.error = false

      this.status = {
        message: 'stopping',
        level: 'warning',
        icon: 'fa fa-spin fa-spinner'
      }

      this.button = {
        text: 'Creating...',
        disabled: true
      }

      this.$emit('updateStatus', { status: this.status, processing: this.processing })

      axios.post(`/admin/instances/create.json`, { instance: this.form })
        .then(response => {
          this.button = {
            text: 'Create',
            disabled: false
          }          

          this.error = false
          this.$refs.newInstanceModal.hide()
          this.onReset()
          this.$emit('instancesUpdate')
        })
        .catch(err => {
          if (err.response) {
            console.log(err.response.data);
            console.log(err.response.status);
            console.log(err.response.headers);
          } else if (error.request) {
            console.log(error.request);
          } else {
            console.log('Error', error.message);
          }

          this.error = err.response.data.error

          this.button = {
            text: 'Try Again!',
            disabled: false
          }        
          
          this.$emit('instancesUpdate')
        })      
    },

    onReset () {
      this.form.account_type = null
      this.form.location = null
      this.form.domain_type = ''
      this.form.site_name = ''
      
      this.show.form = false
      this.show.custom_domain = false
    },

    getLocations (type = 'kubernetes') {
      axios.get(`/admin/instances/available-locations?type=${type}`)
        .then(response => {
          this.locations = response.data
            .map(p => {
              return {
                text: p.full_name,
                value: p.str_id
              }
            })
        })
    },

    getDomainTypes () {
      axios.get(`/data/domain_types.json`)
        .then(response => {
          this.domains = response.data
        })
    },

    getPlans () {
      axios.get(`/admin/instances/plans`)
        .then(response => {
          this.plans = response.data
            .map(p => {
              return {
                text: p.name,
                value: p.internal_id
              }
            })
        })
    }

  },

  render () {
    let custom_domain_input = null
    let custom_plan_input = null
    let error_box = null

    if (this.form.domain_type == 'custom') {
      custom_domain_input = <div>
        <p class='alert alert-info'>
          Enter your root custom domain below (Site name).
        </p>
      </div>
    }

    if (this.form.account_type == 'open_source') {
      custom_plan_input = <div>
                    <h5><i class="fa fa-code-branch"></i> Open Source Request</h5>
                    <hr/>
                    <p>This is a open source project request, please make sure to fill all fields
                    carefully as it will be reviewed, typically within 1 business day.
                    You will receive an email once verified.</p>
                    <b-form-group id='input-group-open-source-title' label='Project Title:' label-for='input-open-source-title'>
                      <b-form-input
                        id='input-open-source-title'
                        v-model={this.form.open_source_title}
                        placeholder='Enter project name...'
                      />
                    </b-form-group>
                    <b-form-group id='input-group-open-source-repository' label='Repository URL(github, gitlab, etc):' label-for='input-open-source-repository'>
                      <b-form-input
                        id='input-open-source-repository'
                        v-model={this.form.open_source_repository}
                        placeholder='Enter project repository...'
                      />
                    </b-form-group>
                    <b-form-group id='input-group-open-source-repository' label='Description:' label-for='input-open-source-description'>
                      <b-form-textarea
                        id='input-open-source-description'
                        v-model={this.form.open_source_description}
                        placeholder='Enter project description...'
                      />
                    </b-form-group>       
      </div>
    }    

    if (this.error) {
      error_box = <b-alert variant="critical" show dismissible>
        {this.error}
      </b-alert>
    }

    return (
      <div>
        <b-btn on-click={this.showModal} variant='outline-dark' size={this.buttonSize}>
          <i class='fa fa-plus' /> {this.buttonText}
        </b-btn>
        <b-modal ref='newInstanceModal' hide-footer title='Add New Instance'>

          {error_box}

          <b-form on-submit:prevent={this.onSubmit} on-reset:prevent={this.onReset}>
            <b-form-group id='input-group-1' label='Domain:' label-for='input-1'>
              <b-form-select
                id='input-1'
                v-model={this.form.domain_type}
                options={this.domains}
                required
              />
            </b-form-group>

            {custom_domain_input}

            <b-form-group id='input-group-3' label='Site Name:' label-for='input-3'>
              <b-form-input
                id='input-3'
                v-model={this.form.site_name}
                required
                placeholder='Enter Site name'
              />
            </b-form-group>

            <b-form-group id='input-group-4' label='Location:' label-for='input-4'>
              <b-form-select
                id='input-4'
                v-model={this.form.location}
                options={this.locations}
                required
              />
            </b-form-group>

            <b-form-group id='input-group-5' label='Plan:' label-for='input-5'>
              <b-form-select
                id='input-5'
                v-model={this.form.account_type}
                options={this.plans}
                required
              />
            </b-form-group>
            
            {custom_plan_input}

            <b-button type='submit' variant='success' block={true} disabled={this.button.disabled}>{this.button.text}</b-button>
          </b-form>
        </b-modal>
      </div>
    )
  }
}
