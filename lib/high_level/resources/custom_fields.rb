# frozen_string_literal: true

# GENERATED FROM vendor/openapi/apps/custom-fields.json @ 192cd68b065a7423c543d82721eb8644cdc883c7
# DO NOT EDIT — regenerate via bin/generate.

module HighLevel
  module Resources
    class CustomFields < Base
      # Get Custom Field / Folder By Id
      #
      # <div>
      #                   <p> Get Custom Field / Folder By Id.</p>
      #                   <div>
      #                     <span style= "display: inline-block;
      #                                 width: 25px; height: 25px;
      #                                 background-color: yellow;
      #                                 color: black;
      #                                 font-weight: bold;
      #                                 font-size: 24px;
      #                                 text-align: center;
      #                                 line-height: 22px;
      #                                 border: 2px solid black;
      #                                 border-radius: 10%;
      #                                 margin-right: 10px;">
      #                                 !
      #                       </span>
      #                       <span>
      #                         <strong>
      #                         Only supports Custom Objects and Company (Business) today. Will be extended to other Standard Objects in the future.
      #                         </strong>
      #                       </span>
      #                   </div>
      #                 </div>
      def get_custom_field_by_id(id:, **_opts)
        request(
          method: :get,
          path: "/custom-fields/#{id}",
          security: ["bearer"]
        )
      end

      # Update Custom Field By Id
      #
      # <div>
      #     <p> Update Custom Field By Id </p>
      #     <div>
      #       <span style= "display: inline-block;
      #                   width: 25px; height: 25px;
      #                   background-color: yellow;
      #                   color: black;
      #                   font-weight: bold;
      #                   font-size: 24px;
      #                   text-align: center;
      #                   line-height: 22px;
      #                   border: 2px solid black;
      #                   border-radius: 10%;
      #                   margin-right: 10px;">
      #                   !
      #         </span>
      #         <span>
      #           <strong>
      #           Only supports Custom Objects and Company (Business) today. Will be extended to other Standard Objects in the future.
      #           </strong>
      #         </span>
      #     </div>
      #   </div>
      def update_custom_field(id:, body:, **_opts)
        request(
          method: :put,
          path: "/custom-fields/#{id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete Custom Field By Id
      #
      # <div>
      #     <p> Delete Custom Field By Id </p>
      #     <div>
      #       <span style= "display: inline-block;
      #                   width: 25px; height: 25px;
      #                   background-color: yellow;
      #                   color: black;
      #                   font-weight: bold;
      #                   font-size: 24px;
      #                   text-align: center;
      #                   line-height: 22px;
      #                   border: 2px solid black;
      #                   border-radius: 10%;
      #                   margin-right: 10px;">
      #                   !
      #         </span>
      #         <span>
      #           <strong>
      #           Only supports Custom Objects and Company (Business) today. Will be extended to other Standard Objects in the future.
      #           </strong>
      #         </span>
      #     </div>
      #   </div>
      def delete_custom_field(id:, **_opts)
        request(
          method: :delete,
          path: "/custom-fields/#{id}",
          security: ["bearer"]
        )
      end

      # Get Custom Fields By Object Key
      #
      # <div>
      #                   <p> Get Custom Fields By Object Key</p>
      #                   <div>
      #                     <span style= "display: inline-block;
      #                                 width: 25px; height: 25px;
      #                                 background-color: yellow;
      #                                 color: black;
      #                                 font-weight: bold;
      #                                 font-size: 24px;
      #                                 text-align: center;
      #                                 line-height: 22px;
      #                                 border: 2px solid black;
      #                                 border-radius: 10%;
      #                                 margin-right: 10px;">
      #                                 !
      #                       </span>
      #                       <span>
      #                         <strong>
      #                         Only supports Custom Objects and Company (Business) today. Will be extended to other Standard Objects in the future.
      #                         </strong>
      #                       </span>
      #                   </div>
      #                 </div>
      def get_custom_fields_by_object_key(object_key:, location_id: nil, **_opts)
        request(
          method: :get,
          path: "/custom-fields/object-key/#{object_key}",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Create Custom Field Folder
      #
      # <div>
      #     <p> Create Custom Field Folder </p>
      #     <div>
      #       <span style= "display: inline-block;
      #                   width: 25px; height: 25px;
      #                   background-color: yellow;
      #                   color: black;
      #                   font-weight: bold;
      #                   font-size: 24px;
      #                   text-align: center;
      #                   line-height: 22px;
      #                   border: 2px solid black;
      #                   border-radius: 10%;
      #                   margin-right: 10px;">
      #                   !
      #         </span>
      #         <span>
      #           <strong>
      #           Only supports Custom Objects and Company (Business) today. Will be extended to other Standard Objects in the future.
      #           </strong>
      #         </span>
      #     </div>
      #   </div>
      def create_custom_field_folder(body:, **_opts)
        request(
          method: :post,
          path: "/custom-fields/folder",
          security: ["bearer"],
          body: body
        )
      end

      # Update Custom Field Folder Name
      #
      # <div>
      #     <p> Create Custom Field Folder </p>
      #     <div>
      #       <span style= "display: inline-block;
      #                   width: 25px; height: 25px;
      #                   background-color: yellow;
      #                   color: black;
      #                   font-weight: bold;
      #                   font-size: 24px;
      #                   text-align: center;
      #                   line-height: 22px;
      #                   border: 2px solid black;
      #                   border-radius: 10%;
      #                   margin-right: 10px;">
      #                   !
      #         </span>
      #         <span>
      #           <strong>
      #           Only supports Custom Objects and Company (Business) today. Will be extended to other Standard Objects in the future.
      #           </strong>
      #         </span>
      #     </div>
      #   </div>
      def update_custom_field_folder(id:, body:, **_opts)
        request(
          method: :put,
          path: "/custom-fields/folder/#{id}",
          security: ["bearer"],
          body: body
        )
      end

      # Delete Custom Field Folder
      #
      # <div>
      #     <p> Create Custom Field Folder </p>
      #     <div>
      #       <span style= "display: inline-block;
      #                   width: 25px; height: 25px;
      #                   background-color: yellow;
      #                   color: black;
      #                   font-weight: bold;
      #                   font-size: 24px;
      #                   text-align: center;
      #                   line-height: 22px;
      #                   border: 2px solid black;
      #                   border-radius: 10%;
      #                   margin-right: 10px;">
      #                   !
      #         </span>
      #         <span>
      #           <strong>
      #           Only supports Custom Objects and Company (Business) today. Will be extended to other Standard Objects in the future.
      #           </strong>
      #         </span>
      #     </div>
      #   </div>
      def delete_custom_field_folder(id:, location_id: nil, **_opts)
        request(
          method: :delete,
          path: "/custom-fields/folder/#{id}",
          security: ["bearer"],
          params: { "locationId" => location_id }.compact
        )
      end

      # Create Custom Field
      #
      # <div>
      #                   <p> Create Custom Field </p>
      #                   <div>
      #                     <span style= "display: inline-block;
      #                                 width: 25px; height: 25px;
      #                                 background-color: yellow;
      #                                 color: black;
      #                                 font-weight: bold;
      #                                 font-size: 24px;
      #                                 text-align: center;
      #                                 line-height: 22px;
      #                                 border: 2px solid black;
      #                                 border-radius: 10%;
      #                                 margin-right: 10px;">
      #                                 !
      #                       </span>
      #                       <span>
      #                         <strong>
      #                         Only supports Custom Objects and Company (Business) today. Will be extended to other Standard Objects in the future.
      #                         </strong>
      #                       </span>
      #                   </div>
      #                 </div>
      def create_custom_field(body:, **_opts)
        request(
          method: :post,
          path: "/custom-fields/",
          security: ["bearer"],
          body: body
        )
      end
    end
  end
end
