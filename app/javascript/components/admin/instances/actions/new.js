import axios from 'axios'

export default {
  name: 'New',

  data: function () {
    return {
      error: null,
      modalShow: false,
      form: {
        domain_type: '',
        site_name: '',
        plan: '',
        location: '',
        domain: ''
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

      axios.post(`/admin/instances/create.json`,{instance: this.form})
        .then(response => {
          this.$emit('getInstances')

          this.button = {
            text: 'Create',
            disabled: false
          }          

          this.$refs.newInstanceModal.hide()
          this.onReset()
        })
        .catch(err => {
          this.error = err;
        })      
    },

    onReset () {
      this.form.plan = null
      this.form.location = null
      this.form.domain_type = ''
      this.form.site_name = ''
      this.form.domain = ''
      
      this.show.form = false
      this.show.custom_domain = false
    },

    getLocations () {
      axios.get(`/data/locations.json`)
        .then(response => {
          this.locations = response.data
        })
    },

    getDomainTypes () {
      axios.get(`/data/domain_types.json`)
        .then(response => {
          this.domains = response.data
        })
    },

    getPlans () {
      axios.get(`/data/plans.json`)
        .then(response => {
          this.plans = response.data
        })
    }

  },

  render () {
    let custom_domain_input = null
    let error_box = null

    if (this.form.domain_type == 'custom') {
      custom_domain_input = <div>
        <p class='alert alert-info'>
          Enter all aliases for one given custom domain, one per line. Example:
          <br /><br />
          mydomain.com<br />
          www.mydomain.com<br />
          blog.mydomain.com
        </p>
        <b-form-group id='input-group-2' label='Custom Domain:' label-for='input-2'>
          <b-form-textarea
            id='input-2'
            v-model={this.form.domain}
            placeholder='Your Domain'
          />
        </b-form-group>
      </div>
    }

    if (this.error) {
      error_box =   <b-alert show dismissible>
        {this.error}
      </b-alert>
    }

    return (
      <div>
        <b-btn on-click={this.showModal} variant='outline-dark' size='sm'>
          <i class='fa fa-plus' /> Add New
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
                v-model={this.form.name}
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
                v-model={this.form.plan}
                options={this.plans}
                required
              />
            </b-form-group>

            <b-button type='submit' variant='success' block={true} disabled={this.button.disabled}>{this.button.text}</b-button>
          </b-form>
        </b-modal>
      </div>
    )
  }
}
