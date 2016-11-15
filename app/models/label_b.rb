class LabelB < Label

  # Header and footer
  HEADER = 0
  FOOTER = 0

  # These are the widths and heights for section 1 labels
  SEC1H = 144
  SEC1GAP = 27
  LABEL1W = 217.5
  LABEL1H = SEC1H
  LABEL2W = 31.5
  LABEL2H = SEC1H - SEC1GAP
  LABEL3W = LABEL2W
  LABEL3H = LABEL2H 
  LABEL4W = LABEL2W 
  LABEL4H = LABEL2H
  LABEL5W = LABEL2W 
  LABEL5H = LABEL2H 
  LABEL6W = LABEL2W 
  LABEL6H = LABEL2H 
  LABEL7W = 227
  LABEL7H = SEC1H
  GAP = 1

  # These are the widths and heights for section 2 labels
  SEC2GAP = 4
  SEC2EMPTY = 22
  SEC2H = 50 + SEC2GAP + SEC2EMPTY
  LABEL8W = 217.5
  LABEL8H = SEC2H - SEC2EMPTY - SEC2GAP
  LABEL9W = 157.5
  LABEL9H = LABEL8H
  LABEL10W = 227
  LABEL10H = LABEL8H
  
  # These are the widths and heights for section 3 labels
  SEC3H = 562
  LABEL11W = 419
  LABEL11H = SEC3H
  LABEL12FOOT = 30
  LABEL12W = 183
  LABEL12H = 283 - LABEL12FOOT
  LABEL13FOOT = 20
  LABEL13W = LABEL12W
  LABEL13H = SEC3H - LABEL12H - LABEL12FOOT - LABEL13FOOT

  # Builds the label one section at a time, passing in some constants such as font
  # and font size, line spacing, and padding.
  def build_label
    default_leading SPACING
    pad(HEADER) do
      font(FONT, size: FONT_M) do
        stroke_axis
        grab_data
        sec1
        sec2
        sec3
      end
    end
  end

  # First section of the label page, containing 7 blocks
  def sec1
    label1
    label2
    label3
    label4
    label5
    label6
    label7
  end

  # First block of the label page
  def label1
    bounding_box([0, HEIGHT - HEADER], width: LABEL1W, height: LABEL1H) do
      pad_left = PAD
      if(@print_barcode_on_label)
        pad_right = PAD + BAR_H
        rotate(90, origin: [LABEL1W - PAD / 2, PAD * 2]) do 
          @barcode.annotate_pdf(self, {x: LABEL1W - PAD / 2, y: PAD * 2, xdim: BAR_W, height: BAR_H})
        end
      else
        pad_right = PAD
      end
      stroke_bounds
      indent(pad_left, pad_right) do
        add_heading(0, LABEL1H, LABEL1W - pad_left - PAD * 1.5, 30)
        float do text "<b>RX# #{@rx_number}</b>", inline_format: true end
        text "#{@last_filled}", align: :right
        float do text "<b>#{@patient}</b>", inline_format: true end
        text "Qty #{trim(@dispensed)}", align: :right, leading: SPACE_LESS
        text "#{@doctor}", size: FONT_M - 1
        text_box "#{@directions}", at: [0, cursor + PAD / 4], width: LABEL1W - pad_left - pad_right, height: FONT_M * 5 + PAD / 2, valign: :center
        move_down FONT_M * 5 + PAD / 2
        text_box "#{trim(@dispensed).to_s} <b>#{@drug}</b>", at: [0, cursor], width: LABEL1W - pad_left - pad_right, height: FONT_M, inline_format: true, leading: SPACE_LESS
        move_down FONT_M
        text "#{@manufacturer}\n", size: FONT_S
        float do text "NDC# #{@ndc}", size: FONT_S end
        text "RPh #{@pharmacist}", align: :right, size: FONT_S
        if(@refill_thru_date)
          float do text "REFILL UNTIL #{@refill_thru}", inline_format: true, size: FONT_S, character_spacing: CHAR_SPACING end
        elsif(@enter_discard_date)
          float do text "DISCARD AFTER #{@discard_date}", inline_format: true, size: FONT_S, character_spacing: CHAR_SPACING end
        elsif(@enter_expiration_date)
          float do text "EXPIRES #{@expires}", inline_format: true, size: FONT_S, character_spacing: CHAR_SPACING end
        end
        if(@remaining == 0)
          text "#{@remaining} REFILLS", align: :right, size: FONT_S, character_spacing: CHAR_SPACING
        elsif (@remaining == 1)
          text "#{@remaining} REFILL BEFORE #{@expires}", align: :right, size: FONT_S, character_spacing: CHAR_SPACING
        else
          text "#{@remaining} REFILLS BEFORE #{@expires}", align: :right, size: FONT_S, character_spacing: CHAR_SPACING
        end
      end
    end
  end

  # Second block of the label page
  def label2
    bounding_box([LABEL1W, HEIGHT - HEADER - SEC1GAP], width: LABEL2W, height: LABEL2H) do
      stroke_bounds
      indent(PAD, PAD) do
        if(@print_warning_labels)
          draw_text "WARNING LABEL", at: [PAD + GAP, PAD], rotate: 90
        end
      end
    end
  end

  # Third block of the label page
  def label3
    bounding_box([LABEL1W + LABEL2W, HEIGHT - HEADER - SEC1GAP], width: LABEL3W, height: LABEL3H) do
      stroke_bounds
      indent(PAD, PAD) do
        if(@print_warning_labels)
          draw_text "WARNING LABEL", at: [PAD + GAP, PAD], rotate: 90
        end
      end
    end
  end

  # Forth block of the label page
  def label4
    bounding_box([LABEL1W + LABEL2W + LABEL3W, HEIGHT - HEADER - SEC1GAP], width: LABEL4W, height: LABEL4H) do
      stroke_bounds
      indent(PAD, PAD) do
        if(@print_warning_labels)
          draw_text "WARNING LABEL", at: [PAD + GAP, PAD], rotate: 90
        end
      end
    end
  end

  # Fifth block of the label page
  def label5
    bounding_box([LABEL1W + LABEL2W + LABEL3W + LABEL4W, HEIGHT - HEADER - SEC1GAP], width: LABEL5W, height: LABEL5H) do
      stroke_bounds
      indent(PAD, PAD) do
        if(@print_warning_labels)
          draw_text "WARNING LABEL", at: [PAD + GAP, PAD], rotate: 90
        end
      end
    end
  end

  # Sixth block of the label page
  def label6
    bounding_box([LABEL1W + LABEL2W + LABEL3W + LABEL4W + LABEL5W, HEIGHT - HEADER - SEC1GAP], width: LABEL6W, height: LABEL6H) do
      stroke_bounds
      indent(PAD, PAD) do
        if(@print_warning_labels)
          draw_text "WARNING LABEL", at: [PAD + GAP, PAD], rotate: 90
        end
      end
    end
  end

  # Seventh block of the label page
  def label7
    bounding_box([LABEL1W + LABEL2W + LABEL3W + LABEL4W + LABEL5W + LABEL6W, HEIGHT - HEADER], width: LABEL7W, height: LABEL7H) do
      stroke_bounds
      indent(PAD, PAD) do
        font(FONT, size: FONT_S) do
          move_down PAD / 3
          text "<b>RX# #{@rx_number}</b>", size: FONT_MS, inline_format: true
          float do text "<b>#{@patient}</b>", size: FONT_MS, inline_format: true end
          text "#{@patient_phone}\n", align: :right, size: FONT_MS, leading: SPACE_LESS
          text_box "#{@patient_addr_short}", at: [0, cursor], width: LABEL7W - PAD * 2, height: FONT_MS, overflow: :shrink_to_fit, valign: :center
          move_down FONT_MS + PAD / 3
          text "DW #{@written}  DF #{@last_filled}  DOB #{@patient_birth}", size: FONT_MS
          move_down PAD / 3
          temp_height = cursor
          text_box "#{@directions}", at: [0, temp_height + PAD / 4], width: (LABEL7W - PAD * 2) * 0.6 - PAD, height: FONT_S * 5 + PAD / 2, valign: :center
          move_down FONT_S * 5 + PAD / 2
          bounding_box([(LABEL7W - PAD * 2) * 0.6, temp_height + PAD / 4], width: (LABEL7W - PAD * 2) * 0.4, height: FONT_S * 5 + PAD / 2) do
            text sprintf("Cost     $%5.2f", @cost)
            text sprintf("Awp      $%5.2f", @awp)
            text sprintf("Price    $%5.2f", @price)
            text sprintf("Fee      $%5.2f", @fee)
            if( @print_discount_on_label )
              text "#{sprintf("Discount $%5.2f", @discount)}\n"
            else
              text "\n"
            end
          end
          text_box "<b>#{@drug}</b>", at: [0, cursor], width: (LABEL7W - PAD * 2) * 0.8, height: FONT_MS, size: FONT_MS, inline_format: true
          text "(#{@manufacturer})\n", size: FONT_MS, align: :right
          text "NDC# #{@ndc}  AUTH# #{@claim}", size: FONT_MS
          text "<b>#{@doctor}</b>", size: FONT_MS, inline_format: true
          text_box "#{@doctor_addr_short}", at: [0, cursor + PAD / 2], width: LABEL7W - PAD * 2, height: FONT_S, overflow: :shrink_to_fit, valign: :center
          move_down FONT_S
          float do text "#{@doctor_phone} #{@dea}", size: FONT_MS end
          text "DAW: #{@daw}", align: :right, size: FONT_MS
          float do text "#{sprintf("#{@plan_id} $%5.2f", @plan_amount)}" end
          if(@copay != "")
            text "#{sprintf("COPAY $%5.2f", @copay)}", align: :right
          else
            text "\n"
          end
          if(@remaining == 0)
            float do text "#{@remaining} REFILLS" end
          elsif (@remaining == 1)
            float do text "#{@remaining} REFILL BEFORE #{@expires}" end
          else
            float do text "#{@remaining} REFILLS BEFORE #{@expires}" end
          end
          text "DS:#{@days}  SC:#{@childproof}  ##{trim(@dispensed).to_s}", align: :right
        end
      end
    end
  end

  # Second section of the label page, containing 3 blocks
  def sec2
    label8
    label9
    label10
  end

  # Eighth block of the label page
  def label8
    bounding_box([0, HEIGHT - HEADER - SEC1H - SEC2GAP], width: LABEL8W, height: LABEL8H) do
      stroke_bounds
      indent(PAD * 5, PAD) do
        move_down PAD / 2
        if(@third_party)
          @text = "_X_ 3rd Party"
        else
          @text = "___ 3rd Party"
        end
        if(@counseling)
          @text += " _X_ Counseling"
        else 
          @text += " ___ Counseling"
        end
        if(@childproof == "N")
          @text += " _X_ N.S.C."
        else
          @text += " ___ N.S.C."
        end
        text "#{@text}", size: FONT_S
        move_down PAD / 2
        float do text "DF: #{@last_filled}", size: FONT_MS end
        text "<b>RX# #{@rx_number}</b>", align: :right, inline_format: true, size: FONT_MS
        move_down PAD / 2
        float do text "#{@patient}" end
        text "#{@plan}", align: :right
        move_down PAD / 2
        text "Signature_______________________________", size: FONT_S
      end
    end
  end

  # Ninth block of the label page
  def label9
    bounding_box([LABEL8W, HEIGHT - HEADER - SEC1H - SEC2GAP], width: LABEL9W, height: LABEL9H) do
      stroke_bounds
      indent(PAD, PAD) do
        font(FONT, size: FONT_S) do
          move_down PAD / 3
          text "<b>#{@rx_number}</b> #{@last_filled} Ref.#{@remaining} #{@pharmacist} ##{trim(@dispensed).to_s}", inline_format: true, spacing: SPACE_LESS
          float do text "#{@patient}", style: :bold, spacing: SPACE_LESS end
          if( @copay != "") 
            text sprintf("$%5.2f", @copay), align: :right, spacing: SPACE_LESS
          else
            text sprintf("$%5.2f", @plan_amount), align: :right, spacing: SPACE_LESS
          end
          float do text "#{@doctor}", spacing: SPACE_LESS end
          text "#{@dea}", align: :right, spacing: SPACE_LESS
          text_box "#{@drug}", at: [0, cursor], width: (LABEL9W - PAD * 2) * 0.67, height: FONT_S
          text "#{@ndc}", align: :right, spacing: SPACE_LESS
          text_box "#{@directions}", at: [0, cursor], width: LABEL9W * 0.67, height: FONT_S * 2
          text "#{@manufacturer}\n", align: :right, spacing: SPACE_LESS
          text "DS:#{@days} #{@abbr_paytype}", align: :right, spacing: SPACE_LESS
        end
      end
    end
  end

  # Tenth block of the label page
  def label10
    bounding_box([LABEL8W + LABEL9W, HEIGHT - HEADER - SEC1H - SEC2GAP], width: LABEL10W, height: LABEL10H) do
      stroke_bounds
      indent(PAD, PAD) do
        move_down PAD
        float do text "<b>#{@patient}</b>", inline_format: true end
        text "#{@patient_phone}\n", align: :right
        text "#{@patient_addr_short}"
        float do text "#{@plan}" end
        text "#{@last_filled}", align: :right
      end
    end
  end

  # Third section of the label page, containing 3 blocks
  def sec3
    label11
    label12
    label13
  end

  # Eleventh block of the label page
  def label11
    bounding_box([0, HEIGHT - HEADER - SEC1H - SEC2H], width: LABEL11W, height: LABEL11H) do
      stroke_bounds
      indent(PAD, PAD) do
        add_heading(0, LABEL11H, LABEL11W - PAD * 2, 30)
        indent(PAD * 5, 0) do
          float do text "<b>#{@patient}</b>", inline_format: true end
          text "<b>RX# #{@rx_number}</b> #{@last_filled}", align: :right, inline_format: true
          float do text "#{@doctor}" end
          text "Qty #{trim(@dispensed).to_s}", align: :right
          float do text "#{@pharmacist_full}" end
          if(@remaining == 0)
            text "#{@remaining} REFILLS", align: :right 
          elsif (@remaining == 1)
            text "#{@remaining} REFILL BEFORE #{@expires}", align: :right
          else
            text "#{@remaining} REFILLS BEFORE #{@expires}", align: :right
          end
          text "<b>#{@drug}</b> (#{@manufacturer})", inline_format: true
          text "#{@directions}"
        end
        move_down PAD
        text "#{@pronunciation}\n#{@other_names}\n\n#{@uses}\n\n#{@warning}\n\n#{@disclaimer}"
      end
    end
  end

  # Twelvth block of the label page
  def label12
    bounding_box([LABEL11W, HEIGHT - HEADER - SEC1H - SEC2H], width: LABEL12W, height: LABEL12H) do
      stroke_bounds
      indent(PAD, PAD) do
        add_heading(0, LABEL12H, LABEL12W - PAD * 2, 36)
        text "<b>RX# #{@rx_number}</b>  #{@last_filled}", inline_format: true
        text "<b>#{@patient}</b>", inline_format: true
        text "#{@patient_addr_short}"
        move_down PAD
        text_box "<b>#{@drug}</b>", at: [0, cursor], width: LABEL12W - PAD * 2, height: FONT_M, inline_format: true
        move_down FONT_M
        text "(#{@manufacturer})"
        move_down PAD
        float do text "<b>NDC# #{@ndc}</b>", inline_format: true  end
        text "<b>Qty #{trim(@dispensed)}</b>", align: :right, inline_format: true 
        text "<b>#{@doctor}</b>", inline_format: true 
        text "#{@doctor_addr_short}"
        float do text "#{@doctor_phone}" end
        text "#{@dea}", align: :right
        move_down PAD
        text "AUTH# #{@claim}"
        move_down PAD
        text "#{@plan_id}"
        if( @print_discount_on_label )
          text "#{sprintf("DISCOUNT  $%5.2f", @discount)}"
        end
        if( @copay != "" )
          text "#{sprintf("YOUR COST $%5.2f", @copay)}"
        else
          text "#{sprintf("YOUR COST $%5.2f", @plan_amount)}"
        end
        if( @print_barcode_on_receipt )
          @barcode.annotate_pdf(self, {x: PAD * 7, y: bounds.bottom + PAD * 2, xdim: BAR_W, height: BAR_H})
        end
      end
    end
  end

  # Thirteenth block of the label page
  def label13
    bounding_box([LABEL11W, HEIGHT - HEADER - SEC1H - SEC2H - LABEL12H - LABEL12FOOT], width: LABEL13W, height: LABEL13H) do
      stroke_bounds
      indent(PAD, PAD) do
        add_heading(0, LABEL13H, LABEL13W - PAD * 2, 36)
        text "<b>RX# #{@rx_number}</b>  #{@last_filled}", inline_format: true
        text "<b>#{@patient}</b>", inline_format: true
        text "#{@patient_addr_short}"
        move_down PAD
        text_box "<b>#{@drug}</b>", at: [0, cursor], width: LABEL12W - PAD * 2, height: FONT_M, inline_format: true
        move_down FONT_M
        text "(#{@manufacturer})"
        move_down PAD
        float do text "<b>NDC# #{@ndc}</b>", inline_format: true  end
        text "<b>Qty #{trim(@dispensed)}</b>", align: :right, inline_format: true 
        text "<b>#{@doctor}</b>", inline_format: true 
        text "#{@doctor_addr_short}"
        float do text "#{@doctor_phone}" end
        text "#{@dea}", align: :right
        move_down PAD
        text "AUTH# #{@claim}"
        move_down PAD
        text "#{@plan_id}"
        if( @print_discount_on_label )
          text "#{sprintf("DISCOUNT  $%5.2f", @discount)}"
        end
        if( @copay != "" )
          text "#{sprintf("YOUR COST $%5.2f", @copay)}"
        else
          text "#{sprintf("YOUR COST $%5.2f", @plan_amount)}"
        end
        if( @print_barcode_on_receipt )
          @barcode.annotate_pdf(self, {x: PAD * 7, y: bounds.bottom + PAD * 2, xdim: BAR_W, height: BAR_H})
        end
      end
    end
  end
end