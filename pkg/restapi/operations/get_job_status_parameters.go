// Code generated by go-swagger; DO NOT EDIT.

package operations

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"net/http"

	"github.com/go-openapi/errors"
	"github.com/go-openapi/runtime/middleware"

	strfmt "github.com/go-openapi/strfmt"
)

// NewGetJobStatusParams creates a new GetJobStatusParams object
// with the default values initialized.
func NewGetJobStatusParams() GetJobStatusParams {
	var ()
	return GetJobStatusParams{}
}

// GetJobStatusParams contains all the bound params for the get job status operation
// typically these are obtained from a http.Request
//
// swagger:parameters GetJobStatus
type GetJobStatusParams struct {

	// HTTP Request Object
	HTTPRequest *http.Request `json:"-"`

	/*
	  Required: true
	  In: path
	*/
	JobID string
}

// BindRequest both binds and validates a request, it assumes that complex things implement a Validatable(strfmt.Registry) error interface
// for simple values it will use straight method calls
func (o *GetJobStatusParams) BindRequest(r *http.Request, route *middleware.MatchedRoute) error {
	var res []error
	o.HTTPRequest = r

	rJobID, rhkJobID, _ := route.Params.GetOK("job_id")
	if err := o.bindJobID(rJobID, rhkJobID, route.Formats); err != nil {
		res = append(res, err)
	}

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}

func (o *GetJobStatusParams) bindJobID(rawData []string, hasKey bool, formats strfmt.Registry) error {
	var raw string
	if len(rawData) > 0 {
		raw = rawData[len(rawData)-1]
	}

	o.JobID = raw

	return nil
}
